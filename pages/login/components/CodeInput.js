import React,{useRef} from 'react';
import {TextInput, Keyboard, View,Image} from 'react-native';
import {styles} from './../styles';
const CodeInput = (props) => {
    const {username, setUsername,keyboardType='default'} = props;
    return (
        <View style={styles.item}>
            <Image source={require('./../../../assets/common/icon_lock.png')} resizeMode={'contain'} style={{width:24,height:24,marginRight:5}} />
            <TextInput
                style={styles.input}
                placeholder="请输入验证码"
                value={username}
                onChangeText={value => setUsername(value)}
                keyboardType={keyboardType}
            />
{/*            {username ?
                <TouchableOpacity onPress={() => setUsername('')} activeOpcity={0.8}>
                    <Ionicons name={'ios-close-circle'} style={styles.RightIcon}/>
                </TouchableOpacity>
                : null}*/}
        </View>
    );
};
export default CodeInput;
