import os
import sys

parent_directory = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
module_directory = os.path.join(parent_directory, 'fortyfive')

if parent_directory not in sys.path:
    sys.path.insert(0, parent_directory)

if module_directory not in sys.path:
    sys.path.insert(1, module_directory)

import my_module
