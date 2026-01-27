import unittest
from lambda_utils import splitByLineCount

class TerminatorIdcsShould(unittest.TestCase):
    def test_return_empty_array_for_empty_string(self):
        teminatorIdcs = findTerminatorIdcs("")
        self.assertEqual(terminatorIdcs, [])

    def test_return_empty_array_for_non_terminating_string(self):
        teminatorIdcs = findTerminatorIdcs("nio[vron903u90t2niowv")
        self.assertEqual(terminatorIdcs, [])

    def test_return_empty_array_for_non_terminating_terminators_string(self):
        teminatorIdcs = findTerminatorIdcs('vow...vniw"vw"""p')
        self.assertEqual(terminatorIdcs, [])
