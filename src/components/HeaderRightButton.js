import React from 'react'
import {StyleSheet, Text, TouchableOpacity} from 'react-native';
const HeaderRightButton=({text='完成',onPress})=>{
    return (
        <TouchableOpacity onPress={onPress}><Text style={styles.headerRight}>{text}</Text></TouchableOpacity>
    )
}
const styles = StyleSheet.create({
    headerRight: {
        fontSize: 18,
        color: '#fff',
        marginRight: 10
    },
})
export default HeaderRightButton
