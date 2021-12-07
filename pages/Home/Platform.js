import React, {useState,useEffect} from 'react';
import {
    StyleSheet,
    View,
    ScrollView,
    TouchableOpacity,
    Text,
    Image,
    ImageBackground,
    Dimensions
} from 'react-native';
import {commonStyle} from '../../common/styles';
import {useNavigation} from '@react-navigation/native';
import {connect} from 'react-redux';
import IconButton from './../../components/IconButton';
import {ApiService} from '../../fetch/routes';
import LoadingPage from '../../global/LoadingPage';
import globalActions from '../../global/actions';
import HTML from 'react-native-render-html';
const Platform = ({user,setGlobalLoading,setGlobalError}) => {
    const navigation = useNavigation();
    navigation.setOptions({
        headerTitle: '平台介绍',
        headerLeft: () => <IconButton icon={'angle-left'} style={{marginLeft: 10}} onPress={() => navigation.goBack()}/>,
        ...commonStyle.header,
        headerStyle: {
            backgroundColor: commonStyle.themeColor,
            borderBottomWidth: 0,  //remove ios shadow
            elevation: 0, //remove android shadow
        },
    });
    const [info,setInfo]=useState('')
  const getPlatformIntro=async ()=>{
      try {
          setGlobalLoading({isLoading:true});
          const options = {token: user.token};
          console.log(options)
          const res = await ApiService.platformIntro();
          setInfo(res.data)
          setGlobalLoading({isLoading:false});
      } catch (e) {
          setGlobalLoading({isLoading:false});
          setGlobalError(e.errorMessage);
      }
  }
    useEffect(()=>{
        (async ()=>await getPlatformIntro() )()
    },[])
    return (
        <LoadingPage>
            <ScrollView style={{backgroundColor: '#fff',padding:20,}}>
                <HTML html={ info.content} imagesMaxWidth={Dimensions.get('window').width} />

{/*               <ImageBackground
                   imageStyle={{resizeMode:'cover'}}
                   source={require('./../../assets/user.png')}
                      style={{height:200,backgroundColor: '#fcc'}}/>

              <View style={{marginTop:20}}>
                  <Text style={{color:'#666666',fontSize:16}}>

                      这是厂家介绍这是厂家介绍这是厂家介绍这是厂家介绍这
                      是厂家介绍这是厂家介绍这是厂家介绍这是厂家介绍这是 厂家介绍这是厂家介绍这

                  </Text>
              </View>*/}
            </ScrollView>
        </LoadingPage>
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
        setGlobalLoading: val => dispatch(globalActions.setGlobalLoading(val)),
        setGlobalError: val => dispatch(globalActions.setGlobalError(val)),
    };
};
export default connect(
    mapStateToProps,
    mapDispatchToProps,
)(Platform);


const styles = StyleSheet.create({

});
