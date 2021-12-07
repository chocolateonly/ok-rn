import React from 'react';
import CheckCircleBox from './CheckCircleBox';
import {Image, StyleSheet, TouchableOpacity} from 'react-native';
import {commonStyle} from '../common/styles';
import Text from './Text';
import {List} from '@ant-design/react-native';

const PayMethodItem = ({checked, index, setChecked, img, title = '支付方式'}) => {

    return <List.Item disabled extra={<TouchableOpacity activeOpacity={0.8} onPress={() => setChecked(index)}>
        <CheckCircleBox isChecked={checked === index}/>
    </TouchableOpacity>}>
        <TouchableOpacity activeOpacity={0.8} onPress={() => setChecked(index)} style={commonStyle.flexRowCenter}>
            <Image source={img} resizeMode={'contain'}
                   style={{width: 30, height: 30, marginRight: 10}}/>
            <Text style={styles.itemTitle}>{title}</Text>
        </TouchableOpacity>
    </List.Item>;
};

export default PayMethodItem;

const styles = StyleSheet.create({
    itemTitle: {
        fontSize: 16,
        paddingVertical: 10,
        color: '#333',
    },
});
