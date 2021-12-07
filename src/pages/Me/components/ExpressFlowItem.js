import React from 'react';
import {View, StyleSheet} from 'react-native';
import {commonStyle} from '../../../common/styles';
import Text from '../../../src/components/Text';

const ExpressFlowItem = ({item, isFirst, isLast}) => {
    return (
        <View style={{flexDirection: 'row'}}>
            <View style={{width: 30, position: 'relative'}}>
                <View style={[styles.circle, isFirst ? styles.circle_active : {}]}/>
                {!isLast && <View style={[styles.line, {}]}/>}
            </View>

            <View style={[commonStyle.flexGrow, {paddingBottom: 30}]}>
                <Text style={[styles.title, {color: isFirst ? commonStyle.themeColor : '#999'}]}>{item.context}</Text>
                <Text style={styles.time}>{item.time}</Text>
            </View>

        </View>
    );
};
const styles = StyleSheet.create({
    circle: {
        width: 20,
        height: 20,
        borderColor: 'rgba(93,130,238,0)',
        borderWidth: 3,
        backgroundColor: '#ddd',
        borderRadius: 12,
        position: 'relative',
        zIndex: 9,
    },
    circle_active: {
        borderColor: 'rgba(93,130,238,0.3)',
        backgroundColor: commonStyle.themeColor,
    },
    line: {
        width: 2,
        backgroundColor: '#ddd',
        position: 'absolute',
        height: '100%',
        left: 10,
        top: 3,
    },
    title: {
        fontSize: 16,
    },
    time: {
        marginTop: 3,
        fontSize: 14,
        color: '#ccc',
    },

});
export default ExpressFlowItem;
