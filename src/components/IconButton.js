import React from 'react'
import FontAwesome from 'react-native-vector-icons/FontAwesome';
import {StyleSheet,TouchableOpacity,Image} from 'react-native'

const IconButton = ({onPress=()=>null,img, icon='angle-left', style={}}) => {
  return <TouchableOpacity activeOpacity={0.6} onPress={onPress}>
    {img?<Image source={img} style={{width:20,height:20,marginRight:10}}/>:
        <FontAwesome name={icon} style={[styles.buttonIcon,style]}/>}
  </TouchableOpacity>
}

const styles = StyleSheet.create({
  buttonIcon: {
    fontSize: 34,
    color: '#fff',
    width: 30,
    textAlign: 'center'
  },
})
export default IconButton
