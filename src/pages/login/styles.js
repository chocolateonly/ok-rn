import {StyleSheet} from 'react-native';

export const styles = StyleSheet.create({
  welcomeTextWrapper:{
      justifyContent:'center'
  },
  welcomeText:{
    fontSize:20,
    marginLeft:20,
  },
  forgot:{flex: 0, flexDirection: 'row', justifyContent: 'space-between'},
  forgotText:{
    margin:10,
    color:'#afafaf'
  },
    loginBackground: {
        flex: 1,
        flexDirection: 'column',
    },
    item: {
        paddingHorizontal: 10,
        margin: 10,
        marginTop: 20,
        marginBottom: 0,
        borderBottomWidth: 1,
        borderColor: '#ccc',
        flex: 0,
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'center',
    },
    icon: {
        marginHorizontal: 20,
        fontSize: 20,
        textAlign: 'center',
        color: '#646464',
    },
    RightIcon: {
        fontSize: 22,
        marginRight: 5,
        color: '#ccc',
    },
    input: {
        flex: 1,
        fontSize: 16,
        height:50
    },
});
