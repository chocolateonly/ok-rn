import {combineReducers} from 'redux'
import GlobalReducer from "/global/reducers/index";
import LoginReducer   from '/pages/login/reducers/login'
import HomeReducer from '/pages/Home/reducers/index';
import MeReducer from '/pages/Me/reducers/index'
const reducers = combineReducers({
  GlobalReducer,
  LoginReducer,
  HomeReducer,
  MeReducer,
});
export default reducers;
