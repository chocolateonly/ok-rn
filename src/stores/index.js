import reducers from "../reducers/index";
import {createStore,applyMiddleware} from "redux";
import createSagaMiddleware from 'redux-saga'
import rootSaga from '../saga/index'
const sagaMiddleware = createSagaMiddleware();
const store=createStore(reducers,applyMiddleware(sagaMiddleware));
export default store;

sagaMiddleware.run(rootSaga);