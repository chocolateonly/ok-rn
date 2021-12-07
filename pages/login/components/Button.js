import React, {useEffect, useState} from 'react';
import {
  StyleSheet,
  TouchableOpacity,
  Text,
} from 'react-native';
import {commonStyle} from './../../../common/styles';

const {shadow, themeColor} = commonStyle
const CommonButton = (props) => {

  const {
    title = '', disabled=false, onPress = () => {
    }, style = {}
  } = props;
  return (
    <TouchableOpacity activeOpacity={disabled ? 0.5 : 0.8}
                      onPress={() => !disabled ? onPress() : null}
                      style={[shadow, styles.btn, style, {opacity: disabled ? 0.5 : 1}]}>
      <Text style={styles.text}>{title}</Text>
    </TouchableOpacity>
  );
};
const styles = StyleSheet.create({
  btn: {
    flex: 0,
    margin: 10,
    marginTop: 30,
    padding: 12,
    backgroundColor: themeColor,
    borderRadius: 40,
  },
  text: {
    color: '#fff',
    fontSize: 18,
    textAlign: 'center',
  },
});
export default CommonButton;
