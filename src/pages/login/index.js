import React, {useState, useEffect, useLayoutEffect} from 'react';
import SafeArea from '../../src/components/SafeArea';
import actions from './actions/login';
import {useNavigation} from '@react-navigation/native';
import {
    KeyboardAvoidingView,
    View,
    Platform,
    Text, BackHandler,
    TouchableOpacity,
    TouchableWithoutFeedback,
    Keyboard,
    Image,
} from 'react-native';
import {connect} from 'react-redux';
import {styles} from './styles';
import UsernameInput from './components/UsernameInput';
import CommonButton from './components/Button';
import OtherWay from './components/OtherWay';
import _ from 'lodash';
import {commonStyle} from '../../common/styles';
import CodeInput from './components/CodeInput';
import {ApiService} from '../../fetch/routes';
import globalActions from '../../global/actions';
import AsyncStorage from '@react-native-community/async-storage';
import meActions from '../Me/actions';
import {Toast} from '@ant-design/react-native';

const Login = (props) => {
    const {getUserInfo, setGlobalLoading, setGlobalError, getProfileInfo} = props;
    const navigation = useNavigation();
    useLayoutEffect(() => {
        navigation.setOptions({
            headerTitle: '快捷登录注册',
            headerLeft: () => null,
        });
    }, []);
    //13888888888,18871171849
    const [username, setUsername] = useState('18871171849');
    const [password, setPassword] = useState('');
    const handleUsername = (val) => {
        setUsername(val);
    };

    let lastBackPressed = null;
    const onBack = () => {
        let now = new Date().getTime();
        if (now - lastBackPressed > 2500) {
            lastBackPressed = now;
            Toast.info('再按一次退出程序');
            return true;
        }
        BackHandler.exitApp();
        return true;

    };
    useEffect(() => {
        if (Platform.OS === 'android') {
            BackHandler.addEventListener('hardwareBackPress', onBack);
        }
        return () => {
            if (Platform.OS === 'android') {
                BackHandler.removeEventListener('hardwareBackPress');
            }
        };
    }, []);
    const onLogin = async () => {
        try {
            setGlobalLoading({isLoading: true});
            const params = {
                mobile: username,
                captcha: password,
            };
            const res = await ApiService.loginByPhoneCode(params);
            const token = res.data.userinfo.token;
            await AsyncStorage.setItem('BS_HA__USER_INFO',
                JSON.stringify({token: res.data.userinfo.token, uid: res.data.userinfo.id}),
            );
            getUserInfo(res.data.userinfo);
            const options = {token};
            const profile = await ApiService.getProfileInfo(options);
            getProfileInfo(profile.data);

            setGlobalLoading({isLoading: false});
            navigation.navigate('HomeTabs');
        } catch (e) {
            setGlobalLoading({isLoading: false});
            setGlobalError(e.errorMessage);
        }
    };

    return (

        <SafeArea>
            {/*解决input 不失焦 键盘不收起问题*/}
            <TouchableWithoutFeedback onPress={Keyboard.dismiss} accessible={false}>

                <KeyboardAvoidingView
                    style={[commonStyle.flexGrow, {justifyContent: 'space-between', backgroundColor: '#fff', paddingHorizontal: 20}]}
                    behavior="padding">
                    <View style={styles.welcomeTextWrapper}>
                        <View style={{alignItems: 'center', marginTop: 50}}>
                   {/*   //*/}
                       </View>
                    </View>
                    <View style={{backgroundColor: '#fff'}}>

                        <CommonButton
                            key={_.isEmpty(username) || _.isEmpty(password)}
                            title={'登 录'}
                            onPress={onLogin}
                            disabled={_.isEmpty(username) || _.isEmpty(password)}
                        />



                    </View>
                </KeyboardAvoidingView>
            </TouchableWithoutFeedback>
        </SafeArea>

    );
};
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
        getProfileInfo: val => dispatch(meActions.getProfileInfo(val)),
    };
};
export default connect(
    mapStateToProps,
    mapDispatchToProps,
)(Login);
