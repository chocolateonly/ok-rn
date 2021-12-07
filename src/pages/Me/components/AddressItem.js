import React from 'react';
import {View, StyleSheet, TouchableOpacity} from 'react-native';
import Text from '../../../src/components/Text';
import {commonStyle} from '../../../common/styles';

const AddressItem = ({item, onPressItem, index}) => {
    return (
        <View style={[styles.itemWrapper, {paddingTop: index === 0 ? 20 : 0}]}>
            <View style={styles.left}>
                <Text style={[commonStyle.font16, {color: '#fff', textTransform: 'capitalize'}]}>
                    {item.username.length > 3 ?
                        item.username.substring(0, 2) :
                        item.username.substring(0, 1)
                    }
                </Text>
            </View>

            <View style={commonStyle.flexGrow}>
                <View style={{flexDirection: 'row'}}>
                    <Text style={commonStyle.font16}>{item.username}</Text>
                    <Text style={[commonStyle.font16, {color: commonStyle.font_Gray_color, marginLeft: 5}]}>{item.mobile}</Text>
                </View>
                <Text style={commonStyle.font16}>
                    {item.istate === 1 &&
                    <Text style={{padding: 10}}>
                        <Text style={{fontSize: 16, color: '#fff', backgroundColor: '#FBC7AB', borderRadius: 5}}>
                            {`  默认 `}
                        </Text>
                        {`  `}
                    </Text>
                    }
                    <Text>
                        {`${item.address}`}
                    </Text>
                </Text>
            </View>

            <TouchableOpacity activeOpacity={0.8} onPress={() => onPressItem(item)}>
                <Text style={[styles.edit, commonStyle.font16]}>编辑</Text>
            </TouchableOpacity>
        </View>
    );
};
const styles = StyleSheet.create({
    itemWrapper: {
        flexDirection: 'row',
        alignItems: 'center',
        backgroundColor: '#fff',
        paddingBottom: 20,

    },
    left: {
        marginLeft: 20,
        marginRight: 10,
        width: 60,
        height: 60,
        borderRadius: 30,
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: commonStyle.themeColor,
    },
    edit: {
        borderLeftWidth: 1,
        borderColor: '#d7d7d7',
        paddingVertical: 5,
        paddingLeft: 10,
        paddingRight: 20,
        marginLeft: 10,
        color: '#999',
    },
});
export default AddressItem;
