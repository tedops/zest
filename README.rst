####################
DOCKER @ ZESTFINANCE
####################
A skeleton example of how to structure your filesystem to build Docker images using Make.

----

QUICKSTART
==========

-----------------------------------
1) Set Up A Private Docker Registry
-----------------------------------
.. code-block:: bash

    # docker run --net=host -p 5000:5000 registry

**NOTE:** Do not stop this container once it is running while following this Quickstart.

Test Registry Access:
---------------------
.. code-block:: bash

    # nc -v localhost 5000
    Connection to localhost 5000 port [tcp/commplex-main] succeeded!

----------------------------
2) Tag Your Own Fedora Image
----------------------------
.. code-blocK:: bash

    # docker pull fedora:21
    # docker tag fedora:21 localhost:5000/rhel/fedora:21

Push Tagged Image To Your Private Registry
------------------------------------------
.. code-blocK:: bash

    # docker push localhost:5000/rhel/fedora:21

Remove Existing Images
----------------------
.. code-blocK:: bash

    # docker rmi fedora:21
    # docker rmi localhost:5000/rhel/fedora:21

------------------------
3) Clone This Repository
------------------------
.. code-block:: bash

    # git clone https://github.com/tedops/zest.git

-----------
4) Run Make
-----------
.. code-block:: bash

    # cd zest
    # make qa-agent

----------------------
5) View Your Handiwork
----------------------
- Open http://localhost:5000 to see the Nginx welcome page

----

What This Does
==============
Runs Nginx inside a Fedora 21 container, using an image pulled from your private registry.

- Uses a self-tagged ``localhost:5000/rhel/fedora:21`` as a base container image
    - This is so that running ``docker push`` on that image will go to our private registry
    - **Images without a URL in the tag will be pushed to Docker Hub Registry by default!**
- Installs:
    - ``rpmdelta``
    - ``nginx``
    - ``python-pip``
    - ``python-virtualenv``
- Uses ``virtualenv`` and ``pip`` to install ``supervisor`` to ``/var/venv``
- Configures ``supervisor`` to run ``nginx``
- Runs ``get-port.sh`` to grab an available host port between 6000-7000
- Runs the container and maps the grabbed **host** port to the **container** port 80

