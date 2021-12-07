import types from '/pages/login/types/login'
import {fork, put, take} from 'redux-saga/effects'
import {ApiService} from "../fetch/routes";
import globalActions from '/global/actions/index'
export function* LoginIn(action){
  const req=async (params,options)=>{
      return await ApiService.loginIn('', params, options);
  };
  try {
    yield put(globalActions.setGlobalLoading({isLoading:true}))
    //request
    //
    yield setTimeout(()=>{
       put(globalActions.setGlobalLoading({isLoading:false}))
    },2000)
  }catch (e) {
      yield put(globalActions.setGlobalError(e.errorMessage))
  }
}
export function* watchLoginIn() {
 while (true){
   const action=yield take(types.GET_USER_INFO);
   yield fork(LoginIn,action)
 }
}
