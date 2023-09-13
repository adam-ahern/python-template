"""Test for main module."""
from .context import my_module
from my_module.main import main

def test_main():
    assert main("world") is None
