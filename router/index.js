import React, {useEffect,useState} from 'react';
import {NavigationContainer, useNavigation} from '@react-navigation/native';
import {createStackNavigator} from '@react-navigation/stack';
import {createBottomTabNavigator} from '@react-navigation/bottom-tabs';
import Login from '../pages/login';
import Home from './HomeTabs/Home';
import Courses from './HomeTabs/Courses';

import Me from './HomeTabs/Me';
import {SafeAreaProvider} from 'react-native-safe-area-context';
import IconWithBadge from '../components/IconWithBadge';
import {commonStyle} from '../common/styles';
import AsyncStorage from '@react-native-community/async-storage';
import _ from 'lodash';
import {ApiService} from '../fetch/routes';
import actions from '../pages/login/actions/login';
import meActions from '../pages/Me/actions';
import globalActions from '../global/actions';
import {connect} from 'react-redux';
import Forum from '../pages/Forum';

const Tab = createBottomTabNavigator();
const Stack = createStackNavigator();

function HomeTabs({route}) {
    const navigation = useNavigation();

    const checkToken = (name, e) => {
            e.preventDefault();
            //AsyncStorage.removeItem('BS_HA__USER_INFO');
            AsyncStorage.getItem('BS_HA__USER_INFO', (error, value) => {
                console.log(value)
                if (!error){
                    if (_.isEmpty(value)){
                          navigation.navigate('Login')
                    }else {
                        const {token,uid}=JSON.parse(value)
                        console.log(token)
                        if (!token) navigation.navigate('Login')
                         else navigation.navigate(name)
                    }
                }
            })
    };
    return (
        <Tab.Navigator
            initialRouteName={'Home'}
            tabBarOptions={{
                activeTintColor: commonStyle.tabActiveColor,
                labelStyle:{fontSize:14}
            }}>
            <Tab.Screen name="Home" component={Home}
                        options={{
                            tabBarLabel: '首页',
                            tabBarIcon: ({focused,color, size}) => (<IconWithBadge isImage={true} focused={focused}
                                                                                   img={require('../assets/tabbar/tabbar_home.png')}
                                                                                   activeImg={require('../assets/tabbar/tabbar_home_active.png')}/>),
                        }}/>
            <Tab.Screen name="Courses" component={Courses}
                        listeners={{
                            tabPress: e => checkToken('Courses', e),
                        }}
                        options={{
                            tabBarLabel: '戒瘾小课程',
                            tabBarIcon: ({focused,color, size}) => (<IconWithBadge isImage={true} focused={focused}
                                                                                   img={require('../assets/tabbar/tabbar_ask.png')}
                                                                                   activeImg={require('../assets/tabbar/tabbar_ask_active.png')}/>),
                        }}/>
          <Tab.Screen name="Forum" component={Forum}
                      listeners={{
                        tabPress: e => checkToken('Forum', e),
                      }}
                      options={{
                        tabBarLabel: '论坛',
                        tabBarIcon: ({focused,color, size}) => (<IconWithBadge isImage={true} focused={focused}
                                                                               img={require('../assets/tabbar/tabbar_ask.png')}
                                                                               activeImg={require('../assets/tabbar/tabbar_ask_active.png')}/>),
                      }}/>
            <Tab.Screen name="Me" component={Me}
                        options={{
                            tabBarLabel: '我的',
                            tabBarIcon: ({focused,color, size}) => (<IconWithBadge isImage={true} focused={focused}
                                                                                   img={require('../assets/tabbar/tabbar_me.png')}
                                                                                   activeImg={require('../assets/tabbar/tabbar_me_active.png')}/>),
                        }}
                        listeners={{
                            tabPress: e => checkToken('Me', e),
                        }}/>

        </Tab.Navigator>
    );
}

const AppContainer=({auth,getUserInfo, getProfileInfo,setGlobalError})=> {
    const getAuthInfo = async () => {
        try {
            const storage = await AsyncStorage.getItem('BS_HA__USER_INFO');
            if (_.isEmpty(storage)) {
            } else {
                const {token, uid} = JSON.parse(storage);
                if (!token) {
                } else {
                    getUserInfo({token, uid});
                    const options = {token};
                   /* const profile = await ApiService.getProfileInfo(options);
                    getProfileInfo(profile.data);*/
                }
            }
        } catch (e) {
            console.log(e);
            if(e.errorMessage) setGlobalError(e.errorMessage)
        }
    };
    useEffect(()=>{
        (async ()=>await getAuthInfo())()
    },[])
    return (
        <SafeAreaProvider>
            <NavigationContainer>
                <Stack.Navigator initialRouteName={auth?'HomeTabs':'Login'}>
                    {/*tabs*/}
                    <Stack.Screen name="HomeTabs" component={HomeTabs} options={{headerShown: false}}/>
                    {/*login*/}
                    <Stack.Screen name="Login" component={Login} options={commonStyle.header}/>
                </Stack.Navigator>
            </NavigationContainer>
        </SafeAreaProvider>
    );
}

const mapStateToProps = state => {
    return {
        user: state.LoginReducer,
    };
};
const mapDispatchToProps = dispatch => {
    return {
        getUserInfo: val => dispatch(actions.getUserInfo(val)),
        getProfileInfo: val => dispatch(meActions.getProfileInfo(val)),
        setGlobalError: val => dispatch(globalActions.setGlobalError(val)),
    };
};
export default connect(
    mapStateToProps,
    mapDispatchToProps,
)(AppContainer);
