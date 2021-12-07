import cities_zh from './cities_zh-cn'
export const castProvinces = () => {
  let cities_obj = []  //[code:{code,value,label,cities:[code:{code,value,label,districts:[{code:code,value,label}]}]}]

  for (let k in cities_zh) {
    //console.log(cities_zh[k])
    if (k.slice(2, 6) === '0000') {
      cities_obj[k] = { code: k, value: cities_zh[k], label: cities_zh[k], cities: {} }
    } else if (k.slice(4, 6) === '00') {
      const provinceCode = Object.keys(cities_obj).find(item => item.slice(0, 2) === k.slice(0, 2) && item.slice(2, 6) === '0000')
      cities_obj[provinceCode].cities[k] = { code: k, value: cities_zh[k], label: cities_zh[k], districts: {} }
    } else {
      const provinceCode = Object.keys(cities_obj).find(item => item.slice(0, 2) === k.slice(0, 2) && item.slice(2, 6) === '0000')
      const cityCode = Object.keys(cities_obj[provinceCode].cities).find(item => item.slice(0, 4) === k.slice(0, 4) && item.slice(4, 6) === '00')
      if (cityCode) {
        cities_obj[provinceCode].cities[cityCode].districts[k] = { code: k, value: cities_zh[k], label: cities_zh[k] }
      } else {
        cities_obj[provinceCode].cities[k] = { code: k, value: cities_zh[k], label: cities_zh[k] }
      }
    }
  }
/*
  console.log(cities_obj)*/
  return cities_obj
}

 //[{value,label,children[{value,label,children[{value,label}]}]}]
export const getCities=()=>{
  const getChildren = (cur, str) => {
    if (Object.keys(cur).includes(str)) return Object.values(cur[str])
    return []
  }

  let address_data =[]
  const callback=(arr,str)=>{
    arr.forEach(( cur, index) => {
      let p = {label: cur.label, value: cur.value}
      let c=getChildren(cur,str)

      if (c.length>0) {
        p.children=[]
        c.forEach((it , index) => {
          let pp = {label: it.label, value: it.value}
          let cc=getChildren(it,'districts')
          pp.children=cc
          p.children.push(pp)
        })

      }
      else p.children=c

      address_data.push(p)
    })
    return address_data
  }

  callback(Object.values(castProvinces()),'cities')

  return address_data
}
