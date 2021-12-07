import React, {useState, useEffect} from 'react';
import {
    StyleSheet,
    View,
    ScrollView,
    Text,
    TextInput,
    BackHandler,
    Platform,
} from 'react-native';
import {commonStyle} from '../../common/styles';
import {useNavigation} from '@react-navigation/native';
import SafeArea from '../../src/components/SafeArea';
import {connect} from 'react-redux';
import IconButton from '../../src/components/IconButton';
import {List, Modal, Toast} from '@ant-design/react-native';
import PayMethodItem from '../../src/components/PayMethodItem';
import FullTextButton from '../../src/components/FullTextButton';
import {ApiService} from '../../fetch/routes';
import globalActions from '../../global/actions';
import * as WeChat from 'react-native-wechat';
import Alipay from '../../src/components/Alipay';
import qs from 'qs';

const Pay = ({user, me, home, setGlobalLoading, setGlobalError, route}) => {
    const {callback = () => null} = route.params || {};
    const {orderInfo} = home;
    const {profile} = me;
    const goBack = () => {
        Modal.alert('提示', '确定放弃支付？', [
            {
                text: '放弃',//28, 2020040217253  b
                // 53
                onPress: () => navigation.navigate('MyOrderDetails', {id: orderInfo.id, callback}),
            },
            {text: '去支付', onPress: () => console.log('go pay')},
        ]);
        return true;
    };
    const navigation = useNavigation();
    navigation.setOptions({
        headerTitle: '支付',
        headerLeft: () => <IconButton icon={'angle-left'} style={{marginLeft: 10}} onPress={goBack}/>,
        ...commonStyle.header,
        headerStyle: {
            backgroundColor: commonStyle.themeColor,
            borderBottomWidth: 0,  //remove ios shadow
            elevation: 0, //remove android shadow
        },
    });
    useEffect(() => {
        if (Platform.OS === 'android') {
            BackHandler.addEventListener('hardwareBackPress', goBack);
        }
        return () => {
            if (Platform.OS === 'android') {
                BackHandler.removeEventListener('hardwareBackPress');
            }
        };
    }, []);

    const PayMethods = Number(profile.money) - Number(orderInfo.paymoney) > 0 ? [
        {title: '余额支付(余额充足)', img: require('./../../assets/common/icon_yhk.png'), id: 0},
        {title: '微信支付', img: require('./../../assets/common/icon_wx.png'), id: 1},
        {title: '支付宝支付', img: require('./../../assets/common/icon_zfb.png'), id: 2},
    ] : [
        {title: '微信支付', img: require('./../../assets/common/icon_wx.png'), id: 1},
        {title: '支付宝支付', img: require('./../../assets/common/icon_zfb.png'), id: 2},
    ];
    const [checked, setChecked] = useState(PayMethods[0].id);
    const handlePay = async () => {
        //if ((PayMethods.length===3&&checked>0)||PayMethods.length===2) return Toast.info('微信、支付宝支付待完善！')
        const params = {
            order_id: orderInfo.order_id,
            paytype: checked + 1,
        };
        try {
            setGlobalLoading({isLoading: true});
            let res = await ApiService.pay(params, {token: user.token});
            //fixme:
            if (checked === 1) {
                //微信
                const wx_res = JSON.parse(res.data);
                const isInstalled = await WeChat.isWXAppInstalled();

                if (!isInstalled) {
                    setGlobalLoading({isLoading: false});
                    return Toast.fail('未安装微信或微信登录');
                }
                const wx_params = {
                    partnerId: wx_res.partnerid,  // 商家向财付通申请的商家id
                    prepayId: wx_res.prepayid,   // 预支付订单
                    nonceStr: wx_res.noncestr,   // 随机串，防重发
                    timeStamp: wx_res.timestamp,  // 时间戳，防重发.
                    package: wx_res.package,    // 商家根据财付通文档填写的数据和签名
                    sign: wx_res.sign,       // 商家根据微信开放平台文档对数据做的签名
                };
                const wx_pay = await WeChat.pay(wx_params);
                alert('支付结果' + JSON.stringify(wx_pay));
                if (wx_pay.errCode !== 0) {
                    setGlobalLoading({isLoading: false});
                    setGlobalError(wx_pay.errStr);
                } else {
                    setGlobalLoading({isLoading: false});
                    Toast.info('支付成功');
                    //navigation.navigate('MyOrderDetails', {id: orderInfo.id});
                }
            } else if (checked === 2) {
                //支付宝
                const zfb_res = await Alipay.pay(qs.stringify(res.data));
                alert('支付结果:' + JSON.stringify(zfb_res));
                if (zfb_res.resultStatus === '9000' || zfb_res.ResultStatus === '9000') {
                    //支付成功
                    setGlobalLoading({isLoading: false});
                    Toast.info('支付成功');
                    //navigation.navigate('MyOrderDetails', {id: orderInfo.id});
                } else {
                    //支付失败
                    setGlobalLoading({isLoading: false});
                    setGlobalError(zfb_res.memo);
                }
            } else {
                setGlobalLoading({isLoading: false});
                navigation.navigate('MyOrderDetails', {id: orderInfo.id});
            }
        } catch (e) {
            alert('error:' + JSON.stringify(e));
            setGlobalLoading({isLoading: false});
            setGlobalError(e.errorMessage);
        }

    };
    return (
        <SafeArea>
            <ScrollView>

                <List>
                    <List.Item
                        disabled>
                        <View style={commonStyle.flexRowCenter}>
                            <Text style={commonStyle.formItem.itemTitle}>订单编号</Text>
                            <TextInput editable={false} style={commonStyle.formItem.input} value={orderInfo.order_id.toString()}/>
                        </View>
                    </List.Item>
                    <List.Item
                        disabled>
                        <View style={commonStyle.flexRowCenter}>
                            <Text style={commonStyle.formItem.itemTitle}>订单金额</Text>
                            <TextInput editable={false} style={[commonStyle.formItem.input, {color: '#ff9529'}]} value={`${orderInfo.paymoney}元`}/>
                        </View>
                    </List.Item>
                </List>

                <Text style={styles.listTitle}>支付方式</Text>

                <List>
                    {PayMethods.map((item, index) => {
                        return <PayMethodItem key={item.title}
                                              title={item.title}
                                              img={item.img}
                                              checked={checked}
                                              index={item.id}
                                              setChecked={(checked) => {
                                                  setChecked(checked);
                                              }}/>;
                    })
                    }
                </List>

                <FullTextButton text={'支 付'} handlePress={handlePay}/>

            </ScrollView>
        </SafeArea>
    );

};

const mapStateToProps = state => {
    return {
        user: state.LoginReducer,
        global: state.GlobalReducer,
        home: state.HomeReducer,
        me: state.MeReducer,
    };
};
const mapDispatchToProps = dispatch => {
    return {
        setGlobalLoading: val => dispatch(globalActions.setGlobalLoading(val)),
        setGlobalError: val => dispatch(globalActions.setGlobalError(val)),
    };
};
export default connect(
    mapStateToProps,
    mapDispatchToProps,
)(Pay);


const styles = StyleSheet.create({
    listTitle: {
        fontSize: 16,
        padding: 10,
        color: '#333',
    },
});
