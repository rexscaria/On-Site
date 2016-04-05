import sys
import re


class NotSupportedInputException(Exception):
    pass


class InvalidPolishExpression(Exception):
    pass


class Calculator(object):
    add = staticmethod(lambda a,b: a + b)
    subtract = staticmethod(lambda a,b: a - b)
    multiply = staticmethod(lambda a,b: a*b)
    divide = staticmethod(lambda a,b: float(a)/float(b))
    modulus = staticmethod(lambda a,b: a%b)
    _operand_map = {
        '+': add,
        '-': subtract,
        '*': multiply,
        '/': divide,
        '%': modulus
    }
    _supported_types = [int, float]

    def __init__(self):
        self.storage = []
        self.parameter = None
        _float_re = r"[-+]?(\d+(\.\d*)?|\.\d+)([eE][-+]?\d+)?"
        _int_re = r"[-+]?(0[xX][\dA-Fa-f]+|0[0-7]*|\d+)"
        self._param_re = re.compile("(^{0}$)|(^{1}$)".format(_float_re, _int_re))

    def input(self, value):
        self.param = value.strip()
        if self._sanitize_parameter():
            if not self._is_state_operable():
                raise InvalidPolishExpression("The reverse polish expression is invalid")
            return self._process()
        else:
            raise NotSupportedInputException("{0} Not supported".format(self.param))

    def _sanitize_parameter(self):
        if self._param_re.match(self.param):
            self.param = eval(self.param, {}, {})
            return True
        return True if self._is_param_operator() else False

    def _is_param_operator(self, param=None):
        if param == None:
            param = self.param
        return param in self._operand_map.keys()

    def _is_state_operable(self):
        if self._is_param_operator():
            are_operands_supported = len(self.storage) >= 2 and \
                                     type(self.storage[len(self.storage) - 1]) in self._supported_types and \
                                     type(self.storage[len(self.storage) - 2]) in self._supported_types
            return are_operands_supported
        return True

    def _process(self):
        if self._is_param_operator():
            result = self._process_operator()
        else:
            result = self._process_operand()
        self.parm = None
        return result

    def _process_operator(self):
        operation = self._operand_map.get(self.param)
        operand1 = self.storage.pop()
        operand2 = self.storage.pop()
        result = operation.__func__(operand2, operand1)
        self.storage.append(result)
        return result


    def _process_operand(self):
        self.storage.append(self.param)
        return self.param


if __name__ == "__main__":
    calc = Calculator()
    while True:
        i = raw_input('>')
        if i in ['q', 'Q']:
            sys.exit(0)
        print calc.input(i)
 
