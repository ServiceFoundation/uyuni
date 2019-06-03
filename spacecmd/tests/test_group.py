# coding: utf-8
"""
Test suite for group module of spacecmd
"""

from unittest.mock import MagicMock, patch
from helpers import shell, assert_expect, assert_list_args_expect, assert_args_expect
import spacecmd.group


class TestSCGroup:
    """
    Test suite for "group" module.
    """

    def test_group_addsystems_noargs(self, shell):
        """
        Test do_group_addsystems without arguments.

        :param shell:
        :return:
        """

        shell.help_group_addsystems = MagicMock()
        shell.get_system_id = MagicMock()
        shell.expand_systems = MagicMock()
        shell.client.systemgroup.addOrRemoveSystems = MagicMock()
        shell.ssm.keys = MagicMock()
        mprint = MagicMock()
        logger = MagicMock()
        with patch("spacecmd.group.print", mprint) as prn, \
            patch("spacecmd.group.logging", logger) as lgr:
            spacecmd.group.do_group_addsystems(shell, "")

        assert not shell.get_system_id.called
        assert not shell.ssm.keys.called
        assert not shell.client.systemgroup.addOrRemoveSystems.called
        assert not shell.expand_systems.called
        assert not mprint.called
        assert not logger.error.called
        assert shell.help_group_addsystems.called

    def test_group_addsystems_ssm_no_systems(self, shell):
        """
        Test do_group_addsystems with SSM argument, without systems.

        :param shell:
        :return:
        """
        shell.help_group_addsystems = MagicMock()
        shell.get_system_id = MagicMock()
        shell.expand_systems = MagicMock()
        shell.client.systemgroup.addOrRemoveSystems = MagicMock()
        shell.ssm.keys = MagicMock(return_value=[])
        mprint = MagicMock()
        logger = MagicMock()
        with patch("spacecmd.group.print", mprint) as prn, \
            patch("spacecmd.group.logging", logger) as lgr:
            spacecmd.group.do_group_addsystems(shell, "groupname ssm")

        assert not shell.get_system_id.called
        assert not shell.expand_systems.called
        assert not shell.client.systemgroup.addOrRemoveSystems.called
        assert not mprint.called
        assert not logger.error.called
        assert not shell.help_group_addsystems.called
        assert shell.ssm.keys.called
