import {Platform} from 'react-native'

const themeColor = '#5184F6'
const font_Gray_color='#666666'
const font16={fontSize:16}
const font18={fontSize:18}
const font20={fontSize:20}
const flexGrow={
  flexGrow:1,
  flexShrink:1
}
const flexSpaceBetween={
  flexDirection:'row',
  justifyContent:'space-between'
}
const flexRowCenter={
  flexShrink:1,
  flexDirection: 'row',
  alignItems: 'center'
}
const marginHorizontal={
  marginHorizontal:20
}
const paddingHorizontal ={
  paddingHorizontal:20
}
const formItem={
  input: {
    flexGrow: 1,
    flexShrink: 1,
    textAlign: 'right',
    backgroundColor: '#fff',
    padding: 0,
    marginLeft: 10,
    fontSize:16
  },
  itemTitle: {
    fontSize: 15,
    paddingVertical:10,
    color:'#333'
  },
}

const header = {
  headerTitleAlign: 'center',
  headerTintColor: '#fff',
  headerStyle: {
    backgroundColor: themeColor,
  },
}
const tabActiveColor = themeColor
const shadow = {
  ...Platform.select({
    ios: {
      shadowColor: '#e5e5e5',
      shadowOffset: {x: 5, y: 5},
      shadowOpacity: 0.6,
      shadowRadius: 20
    },
    android: {
      elevation: 5,
    }
  })
}
export const commonStyle = {
  themeColor,
  font_Gray_color,
  header,
  tabActiveColor,
  shadow,
  font16,
  font18,
  font20,
  flexGrow,
  flexSpaceBetween,
  flexRowCenter,
  marginHorizontal,
  paddingHorizontal,
  formItem
}
