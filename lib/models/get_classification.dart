class Classification {
  static List<dynamic> _classifications = [];
  static void updateClassifications(List<dynamic> classifications) {
    _classifications = classifications;
  }

  static int getItemCount() {
    return _classifications.length;
  }

  static String getClassificationAtIndex(int index) {
    return _classifications[index]['label'].toString();
  }
}
