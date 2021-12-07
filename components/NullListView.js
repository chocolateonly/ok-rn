import {View,Image} from 'react-native';
import React from 'react';
import Text from './Text'
import {commonStyle} from '../common/styles';

const NullListView=()=>{
    return <View style={{flex:1,flexDirection:'column',alignItems:'center',justifyContent:'center'}}>
        <Image style={{width:150,height:150}} source={require('../assets/me/orderlist_null.png')} />
        <Text style={{fontSize:18,color:commonStyle.font_Gray_color,marginTop:10}}>暂无数据</Text>
    </View>
}
export default NullListView
