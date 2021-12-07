/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {useEffect, useState} from 'react';
import {Provider} from 'react-redux';
import store from './src/stores';
import AppContainer from "./src/router";
import {Provider as AntdProvider} from '@ant-design/react-native';
import Loading from './src/global/Loading'
import ErrorTip from './src/global/ErrorModal'
import AsyncStorage from '@react-native-community/async-storage';
import _ from 'lodash';
import SplashScreen from "react-native-splash-screen";
import * as WeChat from "react-native-wechat";
const App=() => {
  const [isAuth,setIsAuth]=useState(false)
  const getAuthInfo = async () => {
    try {
      //await AsyncStorage.removeItem('BS_HA__USER_INFO')
      const storage = await AsyncStorage.getItem('BS_HA__USER_INFO');
      if (_.isEmpty(storage)) {
        setIsAuth(false)
      } else {
        const {token, uid} = JSON.parse(storage);
        setIsAuth(!!token)
      }
      SplashScreen.hide();
    } catch (e) {
      console.log(e);
    }
  };
  useState(()=>{
    (async ()=>await getAuthInfo())()
  })

  useEffect(() => {
    (async () => await registerApp())();
  });
  const registerApp = async () => {
    try {
      await WeChat.registerApp('wx91e2d653a0c5bfbf');//从微信开放平台申请
    } catch (e) {
      console.error(e);
    }
  };
  return (
    <Provider store={store}>
      <AntdProvider>
        <AppContainer auth={isAuth}/>

        <Loading />
        <ErrorTip />
      </AntdProvider>
    </Provider>
  );
};

export default App;
