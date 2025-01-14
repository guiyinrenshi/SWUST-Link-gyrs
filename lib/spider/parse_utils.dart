import 'package:html/parser.dart' show parse;

List<List<String>> parseTable(
    String htmlStr, {
      String tableSelector = ".Grid_Line",
      ParseResType type = ParseResType.TEXT,
    }) {
  final document = parse(htmlStr);
  final table = document.querySelector(tableSelector);

  if (table == null) {
    throw Exception("Table with selector '$tableSelector' not found.");
  }

  final lines = table.querySelectorAll("tr");
  List<String> headers = table.querySelectorAll("th").map((th) => th.text.trim()).toList();

  if (headers.isEmpty && lines.isNotEmpty) {
    headers = lines.first.querySelectorAll("td").map((td) {
      return type == ParseResType.TEXT ? td.text.trim() : td.outerHtml.trim();
    }).toList();
  }

  final data = <List<String>>[];
  data.add(headers);

  final rowSpanData = <String>{};
  int lineCount = 0;

  for (final line in lines) {
    final lineData = <String>[];
    if (lineCount == 0) {
      lineCount++;
      continue; // Skip header row
    }

    final cells = line.querySelectorAll("td");
    int spaceCount = 0;
    int currentCount = 0;

    for (int cellNum = 0; cellNum < headers.length; cellNum++) {
      final cellKey = "$lineCount-$cellNum";

      if (rowSpanData.contains(cellKey)) {
        spaceCount++;
        lineData.add(""); // Placeholder for rowspan
        continue;
      } else {
        if (currentCount >= cells.length) {
          lineData.add("");
          continue;
        }

        final cell = cells[currentCount];
        final rowSpanAttr = cell.attributes['rowspan'];
        final content = type == ParseResType.TEXT ? cell.text.trim() : cell.outerHtml.trim();
        lineData.add(content);

        int rowSpan = rowSpanAttr != null ? int.parse(rowSpanAttr) : 1;
        currentCount++;

        if (rowSpan > 1) {
          for (int i = lineCount + 1; i < lineCount + rowSpan; i++) {
            rowSpanData.add("$i-$cellNum");
          }
        }
      }
    }

    data.add(lineData);
    lineCount++;
  }

  return data;
}

enum ParseResType {
  TEXT, // 返回单元格文本内容
  TD,   // 返回单元格的原始 HTML 结构
}
