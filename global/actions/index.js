import type from './../types'
export default {
    setGlobalLoading:val=>({type:type.SET_GLOBAL_LOADING,data:val}),
    setGlobalError:val=>({type:type.SET_GLOBAL_ERROR,data:val}),
    setIsLoadingPage:val=>({type:type.SET_IS_LOADING_PAGE,data:val}),
}
