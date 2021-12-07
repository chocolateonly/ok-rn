import React, {useState, useEffect} from 'react';
import {
    StyleSheet,
    View,
    ScrollView,
    TouchableOpacity,
    Text,
    Image,
    TextInput,
} from 'react-native';
import {commonStyle} from '../../common/styles';
import {useNavigation} from '@react-navigation/native';
import SafeArea from '../../components/SafeArea';
import {connect} from 'react-redux';
import IconButton from '../../components/IconButton';
import {List, Toast} from '@ant-design/react-native';
import ImagePicker from 'react-native-image-crop-picker';
import HeaderRightButton from '../../components/HeaderRightButton';
import FullTextButton from '../../components/FullTextButton';
import {ApiService} from '../../fetch/routes';
import AsyncStorage from '@react-native-community/async-storage';
import globalActions from '../../global/actions';
import {apiBaseUrl} from '../../utils/enum';
import validator from 'validator';
import meActions from './actions';
import HomeActions from './../Home/actions'
import LoginActions from './../login/actions/login'
import AskActions from './../Courses/actions'

const MyInfo = ({user, me, clearLoginData,clearMeData,clearHomeData,clearAskData,getProfileInfo,setGlobalLoading, setGlobalError}) => {
    const {profile} = me;
    const navigation = useNavigation();
    navigation.setOptions({
        headerTitle: '设置',
        headerLeft: () => <IconButton icon={'angle-left'} style={{marginLeft: 10}} onPress={() => navigation.goBack()}/>,
        headerRight: () => <HeaderRightButton text={'完成'} onPress={onEditMyInfo}/>,
        ...commonStyle.header,
        headerStyle: {
            backgroundColor: commonStyle.themeColor,
            borderBottomWidth: 0,  //remove ios shadow
            elevation: 0, //remove android shadow
        },
    });
    const [userImg, setUserImg] = useState(profile.pic);
    const [nickname, setUserName] = useState(profile.nickname);
    const [phone, setUserPhone] = useState(profile.mobile);

    const uploadPickers = async (img) => {
        const formData = new FormData();
        formData.append('file', {uri: img, type: 'image/png', name: 'image.jpg'});
        const options = {
            'Content-Type': 'multipart/form-data',
            token: user.token,
        };
        try {
            const res = await ApiService.uploadImg(formData, options);
            setUserImg(`${apiBaseUrl}${res.data.url}`);
        } catch (e) {
            setGlobalError(e.errorMessage);
        }
    };
    const openPhotoLibrary = async () => {
        try {
            const images = await ImagePicker.openPicker({
                multiple: false,
            });
            await uploadPickers(images.path);
        } catch (e) {
            console.log(e);
        }
    };
    const onEditMyInfo = async () => {

        try {
            if (!validator.isMobilePhone(phone)) {
                return Toast.fail('请输入正确手机号');
            }

            const params = {
                avatar: userImg.replace(apiBaseUrl, ''),
                username: '',
                nickname: nickname,
                mobile: phone,
                bio: '',
            };
            setGlobalLoading({isLoading: true});
            const res = await ApiService.updateUserInfo(params, {token: user.token});
            getProfileInfo({
                pic: userImg,
                nickname,
                mobile: phone
            })
            navigation.navigate('Me');
            setGlobalLoading({isLoading: false});
        } catch (e) {
            setGlobalLoading({isLoading: false});
            setGlobalError(e.errorMessage);
        }

    };
    const loginOut = async () => {
        try {
            setGlobalLoading({isLoading: true});
            const options = {token: user.token};
            const res = await ApiService.loginOut(options);
            console.log(res.data);
            await AsyncStorage.removeItem('BS_HA__USER_INFO');
            clearLoginData()
            clearMeData()
            clearHomeData()
            clearAskData()
            navigation.reset({  index: 0,
                routes: [{ name: 'Login' }],});
            setGlobalLoading({isLoading: false});
        } catch (e) {
            setGlobalLoading({isLoading: false});
            setGlobalError(e.errorMessage);
        }
    };
    const profileImg = userImg ? {uri: userImg} : require('../../assets/user.png');

    return (
        <SafeArea>
            <List>
                <List.Item
                    onPress={openPhotoLibrary}
                    extra={<Image source={profileImg}
                                  style={{width: 30, height: 30, borderRadius: 15,backgroundColor: '#fcc'}}/>}
                    arrow="horizontal">
                    <Text style={commonStyle.formItem.itemTitle}>头像</Text>
                </List.Item>
                <List.Item
                    disabled>
                    <View style={commonStyle.flexRowCenter}>
                        <Text style={commonStyle.formItem.itemTitle}>昵称</Text>
                        <TextInput style={commonStyle.formItem.input} value={nickname} onChangeText={setUserName}/>
                    </View>
                </List.Item>
                <List.Item
                    disabled>
                    <View style={commonStyle.flexRowCenter}>
                        <Text style={commonStyle.formItem.itemTitle}>手机</Text>
                        <TextInput keyboardType={'phone-pad'} style={commonStyle.formItem.input} value={phone} onChangeText={setUserPhone}/>
                    </View>
                </List.Item>
            </List>

            <FullTextButton text={'退出登录'} handlePress={loginOut}/>

        </SafeArea>
    );

};

const mapStateToProps = state => {
    return {
        me: state.MeReducer,
        global: state.GlobalReducer,
        user: state.LoginReducer,
    };
};
const mapDispatchToProps = dispatch => {
    return {
        getProfileInfo: val => dispatch(meActions.getProfileInfo(val)),
        setGlobalLoading: val => dispatch(globalActions.setGlobalLoading(val)),
        setGlobalError: val => dispatch(globalActions.setGlobalError(val)),

        clearLoginData: val => dispatch(LoginActions.clearLoginData(val)),
        clearMeData: val => dispatch(meActions.clearMeData(val)),
        clearHomeData: val => dispatch(HomeActions.clearHomeData(val)),
        clearAskData: val => dispatch(AskActions.clearAskData(val)),
    };
};
export default connect(
    mapStateToProps,
    mapDispatchToProps,
)(MyInfo);



