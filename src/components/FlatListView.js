import React, { PureComponent } from 'react';
import {
  FlatList,
  View,
  StyleSheet,
  Text,
} from 'react-native';
import NullListView from './NullListView';
export const PAGE_SIZE = 5;

class FlatListView extends PureComponent {
  constructor(props) {
    super(props);

    this.state = {
      total: 0,
      data: [],
      loading: false,
      page: 1
    };
  }

  asyncPullData = async () => {
    const {getList}=this.props
    try {
      if (this.state.data.length > this.state.total) return false;
      this.setState({ loading: true });
      const { list, total } = await getList(this.state.page, PAGE_SIZE);
/*      console.log('--------------')
      console.log(JSON.stringify({list,total}))*/
      const data = this.state.data.concat(list);
      this.setState({ data, total, page: this.state.page + 1 });
    } catch (error) {
      console.log(error);
    } finally {
      this.setState({ loading: false });
    }
  };

  async componentDidMount() {
    await this.asyncPullData();
  }

  /**
   * 下拉刷新
   */
  _onRefresh = () => {
    this.setState({ data: [], total: 0, page: 1 },()=>{
      this.asyncPullData();
    });
    console.log('下拉刷新');
  };

  /**
   * 触底操作
   */
  _onEndReached = () => {
    if (this.state.data.length === this.state.total) return false;
    this.asyncPullData();
  };

  /**
   * 用于避免动态测量内容尺寸的开销
   */
  _getItemLayout = (data, index) => ({
    length: 100,
    offset: 100 * index,
    index
  });

  /**
   * 尾部组件
   */
  _ListFooterComponent = () => {
    const { data, total } = this.state;
    if (total===0||data.length < total || this.state.loading) return <View />;
    return (
      <View style={styles.list_footer}>
        <Text style={styles.list_footer_text}>没有更多数据了</Text>
      </View>
    );
  };

  /**
   * 列表为空时渲染该组件
   */
  _ListEmptyComponent = () => {
    if (this.state.loading) return false;
    return (
      <View style={styles.none_wraper}>
        <NullListView/>
      </View>
    );
  };

  /**
   * 为给定的 item 生成一个不重复的 key
   */
  _keyExtractor = (item, index) => `${item.id}_${index}`;

  /**
   * 行与行之间的分隔线组件
   */
  _ItemSeparatorComponent = ({ highlighted, leadingItem }) => {
    return (
      // <View style={[styles.separator, highlighted && { color: 'blue' }]} />
      <View />
    );
  };

  /**
   * 从data中挨个取出数据并渲染到列表
   */
  _renderItem = ({ item, index, separators }) => {

    return this.props.renderItem(item,index,separators)
  };

  _ref = FlatList => {
    this.FlatList = FlatList;
  };


  previewDemoOne = () => {
    const { loading, data,total } = this.state; // getItemLayout={this._getItemLayout}
    const {style}=this.props
    return (
              <View style={[{flex:1,overflow:'hidden' },style]}>
                <FlatList
                    showsVerticalScrollIndicator={false}
                    data={data}
                    refreshing={loading}
                    ref={this._ref}
                    renderItem={this._renderItem}
                    keyExtractor={this._keyExtractor}
                    ItemSeparatorComponent={this._ItemSeparatorComponent}
                    ListEmptyComponent={this._ListEmptyComponent}
                    ListFooterComponent={this._ListFooterComponent}
                    onEndReachedThreshold={0.4}
                    onEndReached={this._onEndReached}
                    onRefresh={this._onRefresh}
                />
              </View>
    );
  };

  render() {
    return (
      <>
        {this.previewDemoOne()}
      </>
    );
  }
}

const styles = StyleSheet.create({
  separator: {
    height: 1,
    backgroundColor: '#999',
    marginTop: 4
  },

  /** none */
  none_wraper: {
    marginTop: 50,
    justifyContent: 'center',
    alignItems: 'center'
  },
  none_wraper_text: {
    fontSize: 16,
    color: '#999'
  },

  /** list_footer */
  list_footer: {
    justifyContent: 'center',
    padding: 10
  },
  list_footer_text: {
    fontSize: 13,
    color: '#666',
    textAlign: 'center'
  }
});

export default FlatListView;
