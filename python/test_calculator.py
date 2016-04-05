from unittest import TestCase
import rpn


class TestCalculator(TestCase):
    def setUp(self):
        self.calculator = rpn.Calculator()
        self.result = []
        self.right_polish = "1 2 + 3 * 6 + 2 3 + /".split(' ')

        self.wrong_input_polish1 = "1 2 ( 3 * 6 + 2 3 + /".split(' ')
        self.wrong_input_polish2 = "1 2 ) 3 * 6 + 2 3 + /".split(' ')
        self.wrong_input_polish3 = "1 k + 3 * 6 + 2 3 + /".split(' ')
        self.wrong_input_polish4 = "1 m > 3 * 6 + 2 3 + /".split(' ')

        self.wrong_polish1 = "2 + 3 * 6 + 2 3 + /".split(' ')
        self.wrong_polish2 = "1 2 5 3 * 6 + 2 3 + / * * *".split(' ')
        self.wrong_polish3 = "1 2 + * 6 + 2 3 + /".split(' ')
        self.wrong_polish4 = "1 2 + 3 * 6 + % 2 3 +".split(' ')

    def process_polish(self, polish):
        for i in polish:
            self.result.append(self.calculator.input(i))

    def test_input(self):
        self.process_polish(self.right_polish)
        self.assertEqual(self.result, [1, 2, 3, 3, 9, 6, 15, 2, 3, 5, 3])

    def test_wrong_operator_input(self):
        self.assertRaises(rpn.NotSupportedInputException, self.process_polish, self.wrong_input_polish1)

        self.calculator = rpn.Calculator()
        self.assertRaises(rpn.NotSupportedInputException, self.process_polish, self.wrong_input_polish2)

        self.calculator = rpn.Calculator()
        self.assertRaises(rpn.NotSupportedInputException, self.process_polish, self.wrong_input_polish3)

        self.calculator = rpn.Calculator()
        self.assertRaises(rpn.NotSupportedInputException, self.process_polish, self.wrong_input_polish4)

    def test_wrong_polish_expression_input(self):
        self.assertRaises(rpn.InvalidPolishExpression, self.process_polish, self.wrong_polish1)

        self.calculator = rpn.Calculator()
        self.assertRaises(rpn.InvalidPolishExpression, self.process_polish, self.wrong_polish2)

        self.calculator = rpn.Calculator()
        self.assertRaises(rpn.InvalidPolishExpression, self.process_polish, self.wrong_polish3)

        self.calculator = rpn.Calculator()
        self.assertRaises(rpn.InvalidPolishExpression, self.process_polish, self.wrong_polish4)



