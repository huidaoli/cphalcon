<?php

/**
 * This file is part of the Phalcon Framework.
 *
 * (c) Phalcon Team <team@phalcon.io>
 *
 * For the full copyright and license information, please view the LICENSE.txt
 * file that was distributed with this source code.
 */

declare(strict_types=1);

namespace Phalcon\Test\Integration\Session\Adapter\Redis;

use IntegrationTester;
use Phalcon\Test\Fixtures\Traits\DiTrait;
use Phalcon\Test\Fixtures\Traits\SessionTrait;

class OpenCest
{
    use DiTrait;

    /**
     * Tests Phalcon\Session\Adapter\Redis :: open()
     *
     * @author Phalcon Team <team@phalcon.io>
     * @since  2018-11-13
     */
    public function sessionAdapterRedisOpen(IntegrationTester $I)
    {
        $I->wantToTest('Session\Adapter\Redis - open()');

        $adapter = $this->newService('sessionRedis');

        $I->assertTrue(
            $adapter->open('test', 'test1')
        );
    }
}
