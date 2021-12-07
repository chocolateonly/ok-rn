import { PixelRatio, Dimensions, Platform } from 'react-native'
const { width: screenW, height: screenH } = Dimensions.get('window');

const fontScale = PixelRatio.getFontScale();

const pixelRatio = PixelRatio.get();

const DEFAULT_DENSITY = 2; // 像素密度

//px转换成dp
//以iphone6为基准,如果以其他尺寸为基准的话,请修改下面的defaultWidth和defaultHeight为对应尺寸即可. 以下为1倍图时
const defaultWidth = 375;
const defaultHeight = 667;
const w2 = defaultWidth / DEFAULT_DENSITY;
const h2 = defaultHeight / DEFAULT_DENSITY;

// 缩放比例
const _scaleWidth = screenW / defaultWidth;
const _scaleHeight = screenH / defaultHeight;

// iPhoneX
const X_WIDTH = 375;
const X_HEIGHT = 812;

/**
 * 屏幕适配,缩放size , 默认根据宽度适配，纵向也可以使用此方法
 * 横向的尺寸直接使用此方法
 * 如：width ,paddingHorizontal ,paddingLeft ,paddingRight ,marginHorizontal ,marginLeft ,marginRight
 * @param size 设计图的尺寸
 * @returns {number}
 */

// sh  =》 scaleHorizontal
export function sh(size) {
  return size * Math.floor(_scaleWidth);
}

/**
 * 屏幕适配 , 纵向的尺寸使用此方法应该会更趋近于设计稿
 * 如：height ,paddingVertical ,paddingTop ,paddingBottom ,marginVertical ,marginTop ,marginBottom
 * @param size 设计图的尺寸
 * @returns {number}
 */

// sv  =》 scaleVertical
export function sv(size) {
  return size * Math.floor(_scaleHeight);
}

// st  =》 scaleText
export function st(size, allowFontScaling = false) {
  const scale = Math.min(_scaleWidth, _scaleHeight);
  const fontSize = allowFontScaling ? 1 : fontScale;
  return size * scale / fontSize;
}

/**
 * 判断是否为iphoneX
 * @returns {boolean}
 */
export function isIphoneX() {
  return (
      Platform.OS === 'ios' &&
      ((screenH === X_HEIGHT && screenW === X_WIDTH) ||
          (screenH === X_WIDTH && screenW === X_HEIGHT))
  )
}

/**
 * 根据是否是iPhoneX返回不同的样式
 * @param iphoneXStyle
 * @param iosStyle
 * @param androidStyle
 * @returns {*}
 */
export function ifIphoneX(iphoneXStyle, iosStyle = {}, androidStyle) {
  if (isIphoneX()) {
    return iphoneXStyle;
  } else if (Platform.OS === 'ios') {
    return iosStyle
  } else {
    if (androidStyle) return androidStyle;
    return iosStyle
  }
}
