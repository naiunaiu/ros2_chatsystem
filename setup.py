from setuptools import find_packages, setup

package_name = 'pkg_kadai'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='naru',
    maintainer_email='imagenaru2@gmail.com',
    description='a package for kadai',
    license='BSD-3-Clause',
    extras_require={
        'test': [
            'pytest',
        ],
    },
    entry_points={
        'console_scripts': [
            'player1 = pkg_kadai.player1:main',
        ],
    },
)
