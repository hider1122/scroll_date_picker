import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:scroll_date_picker/src/widgets/date_scroll_view.dart';

import 'utils/get_monthly_date.dart';
import 'package:syncfusion_flutter_core/core.dart';

class ScrollDatePicker extends StatefulWidget {
  ScrollDatePicker({
    Key? key,
    required this.selectedDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
    required this.onDateTimeChanged,
    Locale? locale,
    DatePickerOptions? options,
    DatePickerScrollViewOptions? scrollViewOptions,
    this.indicator,
    MonthType? type,
  })  : minimumDate = minimumDate ?? DateTime(1960, 1, 1),
        maximumDate = maximumDate ?? DateTime.now(),
        type = type ?? MonthType.en,
        locale = locale ?? const Locale('en'),
        options = options ?? const DatePickerOptions(),
        scrollViewOptions =
            scrollViewOptions ?? const DatePickerScrollViewOptions(),
        super(key: key);

  /// The currently selected date.
  final DateTime selectedDate;

  /// Minimum year that the picker can be scrolled
  final DateTime minimumDate;

  /// Maximum year that the picker can be scrolled
  final DateTime maximumDate;

  /// On optional listener that's called when the centered item changes.
  final ValueChanged<DateTime> onDateTimeChanged;

  /// A set that allows you to specify options related to ListWheelScrollView.
  final DatePickerOptions options;

  /// Set calendar language
  final Locale locale;

  ///  Set calendar month type
  final MonthType type;

  /// A set that allows you to specify options related to ScrollView.
  final DatePickerScrollViewOptions scrollViewOptions;

  /// Indicator displayed in the center of the ScrollDatePicker
  final Widget? indicator;

  @override
  State<ScrollDatePicker> createState() => _ScrollDatePickerState();
}

class _ScrollDatePickerState extends State<ScrollDatePicker> {
  /// This widget's year selection and animation state.
  late FixedExtentScrollController _yearController;

  /// This widget's month selection and animation state.
  late FixedExtentScrollController _monthController;

  /// This widget's day selection and animation state.
  late FixedExtentScrollController _dayController;

  late Widget _yearScrollView;
  late Widget _monthScrollView;
  late Widget _dayScrollView;

  late DateTime _selectedDate;
  bool isYearScrollable = true;
  bool isMonthScrollable = true;
  List<int> _years = [];
  List<int> _months = [];
  List<int> _days = [];

  int get selectedYearIndex => !_years.contains(_selectedDate.year)
      ? 0
      : _years.indexOf(_selectedDate.year);

  int get selectedMonthIndex => !_months.contains(_selectedDate.month)
      ? 0
      : _months.indexOf(_selectedDate.month);

  int get selectedDayIndex =>
      !_days.contains(_selectedDate.day) ? 0 : _days.indexOf(_selectedDate.day);

  int get selectedYear => _years[_yearController.selectedItem % _years.length];

  int get selectedMonth =>
      _months[_monthController.selectedItem % _months.length];

  int get selectedDay => _days[_dayController.selectedItem % _days.length];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _years = [
      for (int i = widget.minimumDate.year; i <= widget.maximumDate.year; i++) i
    ]
        .map((e) => widget.type == MonthType.islamic_ar ||
                widget.type == MonthType.islamic_en
            ? HijriDateTime.fromDateTime(DateTime(e)).year
            : e)
        .toList();

    _initMonths();
    _initDays();
    _yearController = FixedExtentScrollController(initialItem: 0);
    _monthController = FixedExtentScrollController(initialItem: 0);
    _dayController = FixedExtentScrollController(initialItem: 0);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.type == MonthType.islamic_ar ||
          widget.type == MonthType.islamic_en) {
        _selectedDate = widget.selectedDate.isAfter(widget.maximumDate) ||
                widget.selectedDate.isBefore(widget.minimumDate)
            ? HijriDateTime.fromDateTime(DateTime.now()).toDateTime()
            : widget.selectedDate;
      }

      _selectedDate = widget.selectedDate;
      isYearScrollable = false;
      isMonthScrollable = false;
      _yearController.animateToItem(selectedYearIndex,
          curve: Curves.ease, duration: const Duration(microseconds: 500));
      _monthController.animateToItem(selectedMonthIndex,
          curve: Curves.ease, duration: const Duration(microseconds: 500));
      _dayController.animateToItem(selectedDayIndex,
          curve: Curves.ease, duration: const Duration(microseconds: 500));
    });
  }

  @override
  void didUpdateWidget(covariant ScrollDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_selectedDate != widget.selectedDate) {
      _selectedDate = widget.selectedDate;
      isYearScrollable = false;
      isMonthScrollable = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _yearController.animateToItem(selectedYearIndex,
            curve: Curves.ease, duration: const Duration(microseconds: 500));
        _monthController.animateToItem(selectedMonthIndex,
            curve: Curves.ease, duration: const Duration(microseconds: 500));
        _dayController.animateToItem(selectedDayIndex,
            curve: Curves.ease, duration: const Duration(microseconds: 500));
      });
    }
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  void _initDateScrollView() {
    _yearScrollView = DateScrollView(
      dates: _years,
      controller: _yearController,
      options: widget.options,
      scrollViewOptions: widget.scrollViewOptions.year,
      selectedIndex: selectedYearIndex,
      isYearScrollView: true,
      locale: widget.locale,
      onChanged: (_) {
        _onDateTimeChanged();
        _initMonths();
        _initDays();
        if (isYearScrollable) {
          _monthController.jumpToItem(selectedMonthIndex);
          _dayController.jumpToItem(selectedDayIndex);
        }
        isYearScrollable = true;
      },
      type: widget.type,
    );
    _monthScrollView = DateScrollView(
      dates: getMonths(widget.type).sublist(_months.first - 1, _months.last),
      controller: _monthController,
      options: widget.options,
      scrollViewOptions: widget.scrollViewOptions.month,
      selectedIndex: selectedMonthIndex,
      locale: widget.locale,
      isMonthScrollView: true,
      type: widget.type,
      onChanged: (_) {
        _onDateTimeChanged();
        _initDays();
        if (isMonthScrollable) {
          _dayController.jumpToItem(selectedDayIndex);
        }
        isMonthScrollable = true;
      },
    );

    _dayScrollView = DateScrollView(
      dates: _days,
      controller: _dayController,
      options: widget.options,
      scrollViewOptions: widget.scrollViewOptions.day,
      selectedIndex: selectedDayIndex,
      locale: widget.locale,
      type: widget.type,
      onChanged: (_) {
        _onDateTimeChanged();
        _initDays();
      },
    );
  }

  void _initMonths() {
    if (_selectedDate.year == widget.maximumDate.year &&
        _selectedDate.year == widget.minimumDate.year) {
      _months = [
        for (int i = widget.minimumDate.month;
            i <= widget.maximumDate.month;
            i++)
          i
      ];
    } else if (_selectedDate.year == widget.maximumDate.year) {
      _months = [for (int i = 1; i <= widget.maximumDate.month; i++) i];
    } else if (_selectedDate.year == widget.minimumDate.year) {
      _months = [for (int i = widget.minimumDate.month; i <= 12; i++) i];
    } else {
      _months = [for (int i = 1; i <= 12; i++) i];
    }
  }

  void _initDays() {
    int _maximumDay =
        getMonthlyDate(year: _selectedDate.year, month: _selectedDate.month);
    _days = [for (int i = 1; i <= _maximumDay; i++) i];
    if (_selectedDate.year == widget.maximumDate.year &&
        _selectedDate.month == widget.maximumDate.month &&
        _selectedDate.year == widget.minimumDate.year &&
        _selectedDate.month == widget.minimumDate.month) {
      _days = _days.sublist(widget.minimumDate.day - 1, widget.maximumDate.day);
    } else if (_selectedDate.year == widget.maximumDate.year &&
        _selectedDate.month == widget.maximumDate.month) {
      _days = _days.sublist(0, widget.maximumDate.day);
    } else if (_selectedDate.year == widget.minimumDate.year &&
        _selectedDate.month == widget.minimumDate.month) {
      _days = _days.sublist(widget.minimumDate.day - 1, _days.length);
    }
  }

  void _onDateTimeChanged() {
    setState(() {
      _selectedDate = DateTime(selectedYear, selectedMonth, selectedDay);
    });
    widget.onDateTimeChanged(_selectedDate);
  }

  List<Widget> _getScrollDatePicker() {
    _initDateScrollView();
    switch (widget.type) {
      case MonthType.zh:
      case MonthType.ko:
        return [_yearScrollView, _monthScrollView, _dayScrollView];
      case MonthType.vi:
      case MonthType.id:
      case MonthType.th:
      case MonthType.de:
      case MonthType.es:
      case MonthType.nl:
      case MonthType.fr:
        return [_dayScrollView, _monthScrollView, _yearScrollView];
      case MonthType.islamic_ar:
      case MonthType.islamic_en:
        return [_dayScrollView, _monthScrollView, _yearScrollView];
      default:
        return [_monthScrollView, _dayScrollView, _yearScrollView];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: widget.scrollViewOptions.mainAxisAlignment,
          crossAxisAlignment: widget.scrollViewOptions.crossAxisAlignment,
          children: _getScrollDatePicker(),
        ),
        // Date Picker Indicator
        IgnorePointer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: widget.options.borderRadius,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        widget.options.backgroundColor,
                        widget.options.backgroundColor
                            .withOpacity(widget.options.backgroundOpacity),
                      ],
                    ),
                  ),
                ),
              ),
              widget.indicator ??
                  Container(
                    height: widget.options.itemExtent,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.15),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: widget.options.borderRadius,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        widget.options.backgroundColor
                            .withOpacity(widget.options.backgroundOpacity),
                        widget.options.backgroundColor,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
