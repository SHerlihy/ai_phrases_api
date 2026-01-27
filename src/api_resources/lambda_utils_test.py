import unittest
from lambda_utils import findTerminatorIdcs

class TerminatorIdcsShould(unittest.TestCase):
    def test_return_empty_array_for_empty_string(self):
        terminatorIdcs = findTerminatorIdcs("")
        self.assertEqual(terminatorIdcs, [])

    def test_return_empty_array_for_non_terminating_string(self):
        terminatorIdcs = findTerminatorIdcs("nio[vron903u90t2niowv")
        self.assertEqual(terminatorIdcs, [])

    def test_return_empty_array_for_non_terminating_terminators_string(self):
        terminatorIdcs = findTerminatorIdcs('vow...vniw"vw"""p')
        self.assertEqual(terminatorIdcs, [])

class TerminatorIdcsShouldReturnCorrectIdcs(unittest.TestCase):
    def test_for_period_string(self):
        terminatorIdcs = findTerminatorIdcs("0123. 67. 101112.")
        self.assertEqual(terminatorIdcs, [4,8])

    def test_for_punctuation_string(self):
        terminatorIdcs = findTerminatorIdcs("012? 5678! 12. 56?")
        self.assertEqual(terminatorIdcs, [3,9,13])

    def test_for_quotes_string(self):
        terminatorIdcs = findTerminatorIdcs('01234 "789"\n2345')
        self.assertEqual(terminatorIdcs, [10])

    def test_for_newline_string(self):
        terminatorIdcs = findTerminatorIdcs("012?\n5678!\n12.\n56?")
        self.assertEqual(terminatorIdcs, [3,9,13])
