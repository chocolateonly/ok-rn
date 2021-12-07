import React, {useState} from 'react';
import {TextInput, TouchableOpacity, View, Image} from 'react-native';
import {styles} from './../styles';
import Text from './../../../components/Text';
import SecondInterval from './SecondInterval';
import validator from 'validator';
import {Toast} from '@ant-design/react-native';
import {ApiService} from '../../../fetch/routes';

const UsernameInput = (props) => {
    const {username, setUsername, keyboardType = 'default', getPhoneCode} = props;

    const [showButton, setShowButton] = useState(0);
    const handleCode = async () => {
        if (!validator.isMobilePhone(username)) {
            return Toast.fail('请输入正确手机号');
        }

        try {
            const res = await ApiService.sendPhoneCode1({mobile: username,event:'login'});
            //console.log(res)
            setShowButton(1);
            getPhoneCode(res.data.code)
            Toast.info('验证码已发送，请查看手机短信')
        } catch (e) {
           Toast.fail(e.errorMessage)
        }

    };

    return (
        <View style={styles.item}>
            <Image source={require('./../../../assets/common/icon_user.png')}
                   resizeMode={'contain'}
                   style={{width: 24, height: 24, marginRight: 5}}/>
            <TextInput
                allowFontScaling={false}
                style={styles.input}
                placeholder="请输入手机号"
                value={username}
                onChangeText={value => setUsername(value)}
                keyboardType={keyboardType}
            />

            <View style={{paddingLeft: 10, borderLeftWidth: 1, borderColor: '#eee'}}>
                {showButton === 0 ? <TouchableOpacity onPress={handleCode}>
                    <Text style={{color: '#4590FE', fontSize: 16}}>发送验证码</Text>
                </TouchableOpacity> : showButton === 1 ?
                    <Text style={{color: '#4590FE', fontSize: 16}}>
                        已发送 <SecondInterval duration={60} callback={() => setShowButton(2)}/>s
                    </Text> :
                    <TouchableOpacity onPress={handleCode}>
                        <Text style={{color: '#4590FE', fontSize: 16}}>重新发送</Text>
                    </TouchableOpacity>
                }

            </View>
        </View>
    );
};
export default UsernameInput;
