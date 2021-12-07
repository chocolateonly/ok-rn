import React from 'react'
import {StyleSheet, TouchableOpacity} from 'react-native';
import {commonStyle} from '../common/styles';
import Text from './Text'

const FullTextButton=({text='退出登录',handlePress=()=>null})=>{
    return <TouchableOpacity activeOpacity={0.8} onPress={handlePress}>
        <Text style={styles.loginout}>{text}</Text>
    </TouchableOpacity>
}
export default FullTextButton

const styles = StyleSheet.create({
    loginout: {
        fontSize: 18,
        color: commonStyle.themeColor,
        backgroundColor: '#fff',
        marginTop: 10,
        padding: 10,
        textAlign: 'center',
    },
});
