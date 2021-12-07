import React, {useState, useEffect} from 'react';
import {
    StyleSheet,
    View,
    Text, TextInput,
    TouchableOpacity, Image,
} from 'react-native';
import * as WeChat from 'react-native-wechat';
import {Toast} from '@ant-design/react-native';
import actions from '../actions/login';
import globalActions from '../../../global/actions';
import {connect} from 'react-redux';
import {ApiService} from '../../../fetch/routes';
import AsyncStorage from '@react-native-community/async-storage';

const OtherWay = ({getUserInfo, getProfileInfo, navigation, setGlobalLoading, setGlobalError}) => {
    const [weiXinInfo, setWeiXinInfo] = useState('');

    const wxLogin = async () => {
        try {
            const isInstalled = await WeChat.isWXAppInstalled();
            if (!isInstalled) {
                return Toast.fail('未安装微信或微信登录');
            }
            setGlobalLoading({isLoading: true});
            const res = await WeChat.sendAuthRequest('snsapi_userinfo', '');

            let wxl = await fetch(`https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx91e2d653a0c5bfbf&secret=8d9afe9c0def6657b48b22b0b090bd37&code=${res.code}&grant_type=authorization_code`);
            wxl = await wxl.json();
            let finally_res = await fetch(`https://api.weixin.qq.com/sns/userinfo?access_token=${wxl.access_token}&openid=${wxl.openid}`);
            finally_res = await finally_res.json();
            const {openid, nickname, headimgurl} = finally_res;

            setWeiXinInfo(JSON.stringify({openid, token: wxl.access_token, nickname, imgurl: headimgurl}));

            const login_res = await ApiService.weiXinLogin({openid, token: wxl.access_token, nickname, imgurl: headimgurl});
            //alert('res' + JSON.stringify(login_res));

            await AsyncStorage.setItem('BS_HA__USER_INFO',
                JSON.stringify({token: login_res.data.userinfo.token, uid: login_res.data.userinfo.id}),
            );
            getUserInfo(login_res.data.userinfo);
            getProfileInfo(login_res.data.userinfo);
            setGlobalLoading({isLoading: false});
            navigation.navigate('HomeTabs');
        } catch (e) {
            //alert('error:'+JSON.stringify(e))
            console.log(e);
            setGlobalLoading({isLoading: false});
            if (e.ErrCode) {
                setGlobalError(e.ErrCode);
            } else {
                setGlobalError(e.errorMessage);
            }
        }


    };

    return (
        <View style={styles.view}>
           {/* <TextInput>{weiXinInfo}</TextInput>*/}
            <TouchableOpacity style={styles.btn} activeOpacity={0.8} onPress={wxLogin}>
                <Image style={{width: 30, height: 30, marginRight: 5}}
                       resizeMode={'cover'}
                       resizeMethod={'resize'}
                       source={require('./../../../assets/common/icon_wx_circle.png')}/>
                <Text style={{fontSize: 16}}>微信快捷登录</Text>
            </TouchableOpacity>

        </View>
    );
};

const styles = StyleSheet.create({
    view: {
        height: 100,
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'center',
    },
    btn: {
        flex: 0,
        flexDirection: 'row',
        alignItems: 'center',
        backgroundColor: '#F6F7F7',
        borderRadius: 50,
        paddingHorizontal: 20,
        paddingVertical: 10,
    },
});

const mapStateToProps = state => {
    return {
        user: state.LoginReducer,
        global: state.GlobalReducer,
    };
};
const mapDispatchToProps = dispatch => {
    return {
        getUserInfo: val => dispatch(actions.getUserInfo(val)),
        setGlobalError: val => dispatch(globalActions.setGlobalError(val)),
        setGlobalLoading: val => dispatch(globalActions.setGlobalLoading(val)),
    };
};
export default connect(
    mapStateToProps,
    mapDispatchToProps,
)(OtherWay);
