import sys
if sys.prefix == '/usr':
    sys.real_prefix = sys.prefix
    sys.prefix = sys.exec_prefix = '/home/naru/work/ros2_ws/src/pkg_kadai/install/pkg_kadai'
