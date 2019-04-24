
/**
 * This file is part of the Phalcon Framework.
 *
 * (c) Phalcon Team <team@phalconphp.com>
 *
 * For the full copyright and license information, please view the LICENSE.txt
 * file that was distributed with this source code.
 */

namespace Phalcon\Mvc\Model\MetaData;

use Phalcon\Mvc\Model\MetaData;
use Phalcon\Cache\Backend\Libmemcached;
use Phalcon\Cache\Frontend\Data as FrontendData;
use Phalcon\Mvc\Model\Exception;

/**
 * Phalcon\Mvc\Model\MetaData\Libmemcached
 *
 * Stores model meta-data in the Memcache.
 *
 * By default meta-data is stored for 48 hours (172800 seconds)
 *
 *<code>
 * $metaData = new Phalcon\Mvc\Model\Metadata\Libmemcached(
 *     [
 *         "servers" => [
 *             [
 *                 "host"   => "localhost",
 *                 "port"   => 11211,
 *                 "weight" => 1,
 *             ],
 *         ],
 *         "client" => [
 *             Memcached::OPT_HASH       => Memcached::HASH_MD5,
 *             Memcached::OPT_PREFIX_KEY => "prefix.",
 *         ],
 *         "lifetime" => 3600,
 *         "prefix"   => "my_",
 *     ]
 * );
 *</code>
 */
class Libmemcached extends MetaData
{
    protected memcache = null;

    protected metaData = [];

    protected ttl = 172800;

    /**
     * Phalcon\Mvc\Model\MetaData\Libmemcached constructor
     *
     * @param array options
     */
    public function __construct(options = null) -> void
    {
        var ttl;

        if typeof options != "array" {
            let options = [];
        }

        if !isset options["servers"] {
            throw new Exception("No servers given in options");
        }

        if fetch ttl, options["lifetime"] {
            let this->ttl = ttl;
        }

        if !isset options["statsKey"] {
            let options["statsKey"] = "_PHCM_MM";
        }

        let this->memcache = new Libmemcached(
            new FrontendData(["lifetime": this->ttl]),
            options
        );
    }

    /**
     * Reads metadata from Memcache
     */
    public function read(string! key) -> array | null
    {
        var data;

        let data = this->memcache->get(key);

        if typeof data != "array" {
            return null;
        }

        return data;
    }

    /**
     * Writes the metadata to Memcache
     */
    public function write(string! key, array data) -> void
    {
        this->memcache->save(key, data);
    }

    /**
     * Flush Memcache data and resets internal meta-data in order to regenerate it
     */
    public function reset() -> void
    {
        var meta, key, realKey;

        let meta = this->metaData;

        if typeof meta == "array" {
            for key, _ in meta {
                let realKey = "meta-" . key;

                this->memcache->delete(realKey);
            }
        }

        parent::reset();
    }
}
