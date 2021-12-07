import types from './../types'
const initialState = {
    error:'',
    isLoading:false,
    loadingText:'加载中...',

    isLoadingPage:false,
    images:[]
};
const GlobalReducer = (state = initialState, action) => {
    switch (action.type) {
        case types.SET_GLOBAL_ERROR: {
            return {
                ...state,
                error: action.data
            };
        }
        case types.SET_GLOBAL_LOADING: {
            return {
                ...state,
                isLoading: action.data.isLoading,
                loadingText: action.data.loadingText?action.data.loadingText:initialState.loadingText,
            };
        }
        case types.SET_IS_LOADING_PAGE:{
            return {
                ...state,
                isLoadingPage:action.data
            }
        }
        default :
            return state;
    }
};

export default GlobalReducer;
