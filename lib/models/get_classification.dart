class Classification {
  static List<String> _classifications = [
    'mobile phone',
    'book',
    'tablet',
    'phone',
    'book',
    'tablet',
    'phone',
    'book',
    'tablet',
    'bottle'
  ];
  static List<String> getClassifications(String path) {
    print(path);
    return _classifications;
  }

  static int getItemCount() {
    return _classifications.length;
  }

  static String getClassificationAtIndex(int index) {
    return _classifications[index];
  }
}
