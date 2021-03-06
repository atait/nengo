.. image:: https://img.shields.io/pypi/v/nengo.svg
  :target: https://pypi.python.org/pypi/nengo
  :alt: Latest PyPI version

.. image:: https://img.shields.io/travis/nengo/nengo/master.svg
  :target: https://travis-ci.org/nengo/nengo
  :alt: Travis-CI build status

.. image:: https://ci.appveyor.com/api/projects/status/8ou34p2bgqf2qjqh/branch/master?svg=true
  :target: https://ci.appveyor.com/project/nengo/nengo
  :alt: AppVeyor build status

.. image:: https://img.shields.io/codecov/c/github/nengo/nengo/master.svg
  :target: https://codecov.io/gh/nengo/nengo/branch/master
  :alt: Test coverage


********************************************
Nengo: Large-scale brain modelling in Python
********************************************

.. image:: https://www.nengo.ai/design/_images/general-nef-summary.svg
  :width: 100%
  :target: https://doi.org/10.3389/fninf.2013.00048
  :alt: An illustration of the three principles of the NEF

Nengo is a Python library for building and simulating
large-scale neural models.
Nengo can create sophisticated
spiking and non-spiking neural simulations
with sensible defaults in a few lines of code.
Yet, Nengo is highly extensible and flexible.
You can define your own neuron types and learning rules,
get input directly from hardware,
build and run deep neural networks,
drive robots, and even simulate your model
on a completely different neural simulator
or neuromorphic hardware.

********************
The atait/nengo fork
********************
This fork includes feature/fix and experimental branches by atait. The main branch is "atait-dev". Individual branches that have been merged are kept around in case they lead to a pull request. Branches are described here

optimizations-core
==================
Speed up some core functionality, such as

- precomputing sparse matrices

- storing results of missed dictionary lookups.

- One new synapse for 1-input, 1-output only. It uses natural float variables instead of 1x1 np arrays of floats

- just-in-time compile of a workhorse linear operation

neuromorphic-photonics-SciRep-paper
===================================
`Neuromorphic photonic networks using silicon photonic weight banks <https://doi.org/10.1038/s41598-017-07754-z>`_

Solving an ordinary differential equation (Lorenz) with models of a photonic modulator neuron. Includes files for reproducing the conventional benchmark in matlab and comparing the two.

In the nengo package, there is a new neuron for a Mach-Zehnder photonic neuron. Everything else is in the examples directory.

********************************
Back to nengo main documentation
********************************

Installation
============

Nengo depends on NumPy, and we recommend that you
install NumPy before installing Nengo.
If you're not sure how to do this, we recommend using
`Anaconda <https://store.continuum.io/cshop/anaconda/>`_.

To install Nengo::

    pip install nengo

If you have difficulty installing Nengo or NumPy,
please read the more detailed
`Nengo installation instructions
<https://www.nengo.ai/nengo/getting_started.html#installation>`_ first.

If you'd like to install Nengo from source,
please read the `developer installation instructions
<https://www.nengo.ai/nengo/contributing.html#developer-installation>`_.

Nengo is tested to work on Python 3.5 and above.
Python 2.7 and Python 3.4 were supported up to and including Nengo 2.8.0.

Examples
========

Here are six of
`many examples <https://www.nengo.ai/nengo/examples.html>`_
showing how Nengo enables the creation and simulation of
large-scale neural models in few lines of code.

1. `100 LIF neurons representing a sine wave
   <https://www.nengo.ai/nengo/examples/many_neurons.html>`_
2. `Computing the square across a neural connection
   <https://www.nengo.ai/nengo/examples/squaring.html>`_
3. `Controlled oscillatory dynamics with a recurrent connection
   <https://www.nengo.ai/nengo/examples/controlled_oscillator.html>`_
4. `Learning a communication channel with the PES rule
   <https://www.nengo.ai/nengo/examples/learn_communication_channel.html>`_
5. `Simple question answering with the Semantic Pointer Architecture
   <https://www.nengo.ai/nengo/examples/question.html>`_
6. `A summary of the principles underlying all of these examples
   <https://www.nengo.ai/nengo/examples/nef_summary.html>`_

Documentation
=============

Usage and API documentation can be found at
`<https://www.nengo.ai/nengo/>`_.

To build the documentation yourself, run the following command::

    python setup.py build_sphinx

This requires Pandoc to be installed,
as well as some additional Python packages.
For more details, `see the Developer Guide
<https://www.nengo.ai/nengo/contributing.html#how-to-build-the-documentation>`_.

Development
===========

Information for current or prospective developers can be found
at `<https://www.nengo.ai/contributing/>`_.

Getting Help
============

Questions relating to Nengo, whether it's use or it's development, should be
asked on the Nengo forum at `<https://forum.nengo.ai>`_.
