import {all,fork} from 'redux-saga/effects';
import {watchLoginIn} from './login'
function* rootSaga() {
  yield all([
      //fork(watchLoginIn)
  ])
}

export default rootSaga;
