import React from 'react';
import {Image, StyleSheet, TouchableOpacity} from 'react-native';
import Text from './Text';

const IconWithText = ({item,img, index, isLast, onPress,textStyle={}}) => {
    return (
        <TouchableOpacity activeOpacity={0.6} key={item.text}
                          style={[styles.chat_add_tool_item, {marginRight: isLast ? 0 : 10}]}
                          onPress={() => onPress(index)}>
            <Image resizeMode={'contain'} style={styles.chat_add_tool_img} source={img}/>
            <Text style={[styles.chat_add_tool_text,textStyle]}>{item.text}</Text>
        </TouchableOpacity>
    );
};
const styles = StyleSheet.create({
    chat_add_tool_item: {
        flex: 1,
        alignItems: 'center',
        margin: 10,
        marginLeft: 0,
        borderRadius: 10,
        //backgroundColor: '#ccc'
    },
    chat_add_tool_img: {
        width: 30,
        height: 30,
    },
    chat_add_tool_text: {
        marginTop: 10,
        fontSize:16,
        textAlign: 'center',
    },
});
export default IconWithText;
