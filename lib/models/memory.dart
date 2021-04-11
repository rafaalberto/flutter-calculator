class Memory {
  static const operations = const ['+', '-', 'x', '/', '%', '='];

  String _value = '0';

  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;

  String _operation;

  bool _wipeValue = false;

  String get value {
    return _value;
  }

  void setDisplay(String value) {
    if (value == 'AC') {
      _allClear();
    } else if (operations.contains(value)) {
      _setOperation(value);
    } else {
      _setDigit(value);
    }
  }

  _allClear() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _operation = null;
    _bufferIndex = 0;
    _wipeValue = false;
  }

  _setOperation(String operation) {
    bool isEqualSign = operation == '=';
    if (_bufferIndex == 0) {
      if(!isEqualSign) {
        _operation = operation;
        _bufferIndex = 1;
        _wipeValue = true;
      }
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _operation = isEqualSign ? null : operation;
      _bufferIndex = isEqualSign ? 0 : 1;
    }
    _wipeValue = !isEqualSign;
  }

  _setDigit(String digit) {
    final isDot = digit == '.';
    final wipeValue = (_value == '0' && !isDot) || _wipeValue;

    if (isDot && _value.contains('.') && !wipeValue) return;

    final emptyValue = isDot ? '0' : '';

    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + digit;
    _wipeValue = false;

    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
  }

  _calculate() {
    switch (_operation) {
      case '+': return _buffer[0] + _buffer[1]; break;
      case '-': return _buffer[0] - _buffer[1]; break;
      case 'x': return _buffer[0] * _buffer[1]; break;
      case '/': return _buffer[0] / _buffer[1]; break;
      case '%': return _buffer[0] % _buffer[1]; break;
      default: return _buffer[0];
    }
  }
}
