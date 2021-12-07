import React from 'react'
import {Carousel} from '@ant-design/react-native'
import {Image, StyleSheet, TouchableOpacity} from 'react-native';

const CarouselView = ({images}) => {
  const onHorizontalSelectedIndexChange = (index) => null
  return (
    <>
      {images.length > 0 &&
      <Carousel
        style={styles.wrapper}
        selectedIndex={0}
        autoplay
        infinite
        afterChange={onHorizontalSelectedIndexChange}
      >
        {images.map((item, index) => {
          console.log(item)
          return <TouchableOpacity
            key={`item+${index}`}
            activeOpacity={1}
            style={[styles.containerHorizontal, {backgroundColor: 'red'}]}
          >
            <Image resizeMode={'contain'} source={require('./../assets/welcome.jpg')}/>
          </TouchableOpacity>
        })}

      </Carousel>
      }
    </>
  )
}
CarouselView.defaultProps = {
  images: ['./../assets/welcome.jpg',
    './../assets/welcome.jpg',
    './../assets/welcome.jpg']
}
const styles = StyleSheet.create({
  wrapper: {},
  containerHorizontal: {
    alignItems: 'center',
    justifyContent: 'center',
    height: 150,
  }
})
export default CarouselView