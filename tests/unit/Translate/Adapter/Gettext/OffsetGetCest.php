<?php

/**
 * This file is part of the Phalcon Framework.
 *
 * (c) Phalcon Team <team@phalconphp.com>
 *
 * For the full copyright and license information, please view the LICENSE.txt
 * file that was distributed with this source code.
 */

namespace Phalcon\Test\Unit\Translate\Adapter\Gettext;

use UnitTester;

class OffsetGetCest
{
    /**
     * Tests Phalcon\Translate\Adapter\Gettext :: offsetGet()
     *
     * @param UnitTester $I
     *
     * @author Phalcon Team <team@phalconphp.com>
     * @since  2018-11-13
     */
    public function translateAdapterGettextOffsetGet(UnitTester $I)
    {
        $I->wantToTest("Translate\Adapter\Gettext - offsetGet()");
        $I->skipTest("Need implementation");
    }
}