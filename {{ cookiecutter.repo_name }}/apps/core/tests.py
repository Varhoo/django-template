# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.test import Client, TestCase


class GiverTestCase(TestCase):

    def setUp(self):
        self.cli = Client()

    def test_homepage(self):
        response = self.cli.get("/")
        self.assertEqual(200, response.status_code)
