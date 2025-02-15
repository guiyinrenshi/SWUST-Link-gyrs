enum FontType {
  TOP_NAV_FONT(24, "顶部导航栏"),
  TOP_NAV_ACTION(20, "顶部操作区"),
  CARD_TITLE(22, "大标题"),
  LAGER_TITLE(18, "标题"),
  TITLE(15, "小标题"),
  DES(12, "列表描述");

  final int size;
  final String des;

  const FontType(this.size, this.des);
}

