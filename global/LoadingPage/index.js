import React,{useEffect} from 'react'
import SafeArea from '../../components/SafeArea';
import {View,ActivityIndicator} from 'react-native';
import {connect} from 'react-redux';
import {commonStyle} from '../../common/styles';
import {unauthorized} from '../../utils/enum';
import {useNavigation} from '@react-navigation/native';
import actions from '../../pages/login/actions/login';
import AsyncStorage from '@react-native-community/async-storage';
import globalActions from '../actions';

const LoadingPage=props=> {
    const {global,setGlobalError,children}=props
   const navigation=useNavigation()
    useEffect(()=>{
        if (global.error===unauthorized) {
            navigation.navigate('Login')
            setGlobalError('')
            AsyncStorage.removeItem('BS_HA__USER_INFO');
        }
    })

    return (
        <SafeArea>
            {global.isLoadingPage||global.error?
                <View style={{flex: 1,alignItems:'center',justifyContent:'center', backgroundColor: '#fff'}}>
                    {global.error?null:<ActivityIndicator size="large" color={commonStyle.themeColor} />}
                </View>:
                children}
        </SafeArea>
    )
}

const mapStateToProps = state => {
    return {
        global: state.GlobalReducer
    };
};
const mapDispatchToProps = dispatch => {
    return {
        getUserInfo: val => dispatch(actions.getUserInfo(val)),
        setGlobalError: val => dispatch(globalActions.setGlobalError(val)),
    };
};
export default connect(
    mapStateToProps,
    mapDispatchToProps
)(LoadingPage)
