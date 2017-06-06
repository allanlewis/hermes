from setuptools import setup

setup(
    name='hermes',
    version='0.1',
    description='A proxy server for sending notifications to HipChat, Stash, etc.',
    author='Allan Lewis',
    author_email='allanlewis99@gmail.com',
    include_package_data=True,
    license='Not open source',
    entry_points={
          'console_scripts': [
              'start = hermes.scripts.start:run',
              'start_debug = hermes.scripts.start:run_debug'
          ]
      }
)
