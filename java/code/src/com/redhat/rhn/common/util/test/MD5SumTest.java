/**
 * Copyright (c) 2009 Red Hat, Inc.
 *
 * This software is licensed to you under the GNU General Public License,
 * version 2 (GPLv2). There is NO WARRANTY for this software, express or
 * implied, including the implied warranties of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv2
 * along with this software; if not, see
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
 *
 * Red Hat trademarks are not licensed under GPLv2. No permission is
 * granted to use or replicate Red Hat trademarks that are incorporated
 * in this software or its documentation.
 */
package com.redhat.rhn.common.util.test;

import com.redhat.rhn.common.util.MD5Sum;
import com.redhat.rhn.testing.RhnBaseTestCase;
import com.redhat.rhn.testing.TestUtils;

import java.io.File;


/**
 * @author mmccune
 *
 */
public class MD5SumTest extends RhnBaseTestCase {

    public void testMD5Sum() throws Exception {
        File testFile = new File(TestUtils.findTestData("test.file").getFile());
        String sum = MD5Sum.getFileMD5Sum(testFile);
        assertEquals("ab0aa62f30d67085cd07ea9004a1437f", sum);
    }
}
