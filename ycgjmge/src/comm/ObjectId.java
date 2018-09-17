package comm;

import java.io.Serializable;
import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.net.NetworkInterface;
import java.nio.ByteBuffer;
import java.util.Date;
import java.util.Enumeration;
import java.util.Random;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ObjectId implements Comparable<ObjectId>, Serializable{
  private static final long serialVersionUID = -4415279469780082174L;
  static final Logger LOGGER = Logger.getLogger("org.bson.ObjectId");
  final int _time;
  final int _machine;
  final int _inc;
  boolean _new;
  private static AtomicInteger _nextInc = new AtomicInteger(new Random().nextInt());
  private static final int _genmachine;

  public static ObjectId get()
  {
    return new ObjectId();
  }
  public static String oid()
  {
    return new ObjectId().toString();
  }
  public static ObjectId createFromLegacyFormat(int time, int machine, int inc)
  {
    return new ObjectId(time, machine, inc);
  }

  public static boolean isValid(String s)
  {
    if (s == null) {
      return false;
    }
    int len = s.length();
    if (len != 24) {
      return false;
    }
    for (int i = 0; i < len; i++) {
      char c = s.charAt(i);
      if ((c >= '0') && (c <= '9'))
        continue;
      if ((c >= 'a') && (c <= 'f'))
        continue;
      if ((c < 'A') || (c > 'F'))
      {
        return false;
      }
    }
    return true;
  }

  @Deprecated
  public static ObjectId massageToObjectId(Object o)
  {
    if (o == null) {
      return null;
    }
    if ((o instanceof ObjectId)) {
      return (ObjectId)o;
    }
    if ((o instanceof String)) {
      String s = o.toString();
      if (isValid(s)) {
        return new ObjectId(s);
      }
    }
    return null;
  }

  public ObjectId(Date time)
  {
    this(time, _genmachine, _nextInc.getAndIncrement());
  }

  public ObjectId(Date time, int inc)
  {
    this(time, _genmachine, inc);
  }

  @Deprecated
  public ObjectId(Date time, int machine, int inc)
  {
    this._time = (int)(time.getTime() / 1000L);
    this._machine = machine;
    this._inc = inc;
    this._new = false;
  }

  public ObjectId(String s)
  {
    this(s, false);
  }

  @Deprecated
  public ObjectId(String s, boolean babble)
  {
    if (!isValid(s)) {
      throw new IllegalArgumentException("invalid ObjectId [" + s + "]");
    }
    if (babble) {
      s = babbleToMongod(s);
    }
    byte[] b = new byte[12];
    for (int i = 0; i < b.length; i++) {
      b[i] = (byte)Integer.parseInt(s.substring(i * 2, i * 2 + 2), 16);
    }
    ByteBuffer bb = ByteBuffer.wrap(b);
    this._time = bb.getInt();
    this._machine = bb.getInt();
    this._inc = bb.getInt();
    this._new = false;
  }

  public ObjectId(byte[] b)
  {
    if (b.length != 12)
      throw new IllegalArgumentException("need 12 bytes");
    ByteBuffer bb = ByteBuffer.wrap(b);
    this._time = bb.getInt();
    this._machine = bb.getInt();
    this._inc = bb.getInt();
    this._new = false;
  }

  @Deprecated
  public ObjectId(int time, int machine, int inc)
  {
    this._time = time;
    this._machine = machine;
    this._inc = inc;
    this._new = false;
  }

  public ObjectId()
  {
    this._time = (int)(System.currentTimeMillis() / 1000L);
    this._machine = _genmachine;
    this._inc = _nextInc.getAndIncrement();
    this._new = true;
  }

  public int hashCode()
  {
    int x = this._time;
    x += this._machine * 111;
    x += this._inc * 17;
    return x;
  }

  public boolean equals(Object o)
  {
    if (this == o) {
      return true;
    }
    ObjectId other = massageToObjectId(o);
    if (other == null) {
      return false;
    }
    return (this._time == other._time) && (this._machine == other._machine) && (this._inc == other._inc);
  }

  @Deprecated
  public String toStringBabble()
  {
    return babbleToMongod(toStringMongod());
  }

  public String toHexString()
  {
    StringBuilder buf = new StringBuilder(24);

    for (byte b : toByteArray()) {
      buf.append(String.format("%02x", new Object[] { Integer.valueOf(b & 0xFF) }));
    }

    return buf.toString();
  }

  @Deprecated
  public String toStringMongod()
  {
    byte[] b = toByteArray();

    StringBuilder buf = new StringBuilder(24);

    for (int i = 0; i < b.length; i++) {
      int x = b[i] & 0xFF;
      String s = Integer.toHexString(x);
      if (s.length() == 1)
        buf.append("0");
      buf.append(s);
    }

    return buf.toString();
  }

  public byte[] toByteArray()
  {
    byte[] b = new byte[12];
    ByteBuffer bb = ByteBuffer.wrap(b);

    bb.putInt(this._time);
    bb.putInt(this._machine);
    bb.putInt(this._inc);
    return b;
  }

  static String _pos(String s, int p) {
    return s.substring(p * 2, p * 2 + 2);
  }

  @Deprecated
  public static String babbleToMongod(String b)
  {
    if (!isValid(b)) {
      throw new IllegalArgumentException("invalid object id: " + b);
    }
    StringBuilder buf = new StringBuilder(24);
    for (int i = 7; i >= 0; i--)
      buf.append(_pos(b, i));
    for (int i = 11; i >= 8; i--) {
      buf.append(_pos(b, i));
    }
    return buf.toString();
  }

  public String toString() {
    return toStringMongod();
  }

  int _compareUnsigned(int i, int j) {
    long li = 4294967295L;
    li = i & li;
    long lj = 4294967295L;
    lj = j & lj;
    long diff = li - lj;
    if (diff < -2147483648L)
      return -2147483648;
    if (diff > 2147483647L)
      return 2147483647;
    return (int)diff;
  }

  public int compareTo(ObjectId id) {
    if (id == null) {
      return -1;
    }
    int x = _compareUnsigned(this._time, id._time);
    if (x != 0) {
      return x;
    }
    x = _compareUnsigned(this._machine, id._machine);
    if (x != 0) {
      return x;
    }
    return _compareUnsigned(this._inc, id._inc);
  }

  public int getTimestamp()
  {
    return this._time;
  }

  public Date getDate()
  {
    return new Date(this._time * 1000L);
  }

  @Deprecated
  public long getTime()
  {
    return this._time * 1000L;
  }

  @Deprecated
  public int getTimeSecond()
  {
    return this._time;
  }

  @Deprecated
  public int getInc()
  {
    return this._inc;
  }

  @Deprecated
  public int _time()
  {
    return this._time;
  }

  @Deprecated
  public int getMachine()
  {
    return this._machine;
  }

  @Deprecated
  public int _machine()
  {
    return this._machine;
  }

  @Deprecated
  public int _inc()
  {
    return this._inc;
  }

  @Deprecated
  public boolean isNew()
  {
    return this._new;
  }

  @Deprecated
  public void notNew()
  {
    this._new = false;
  }

  @Deprecated
  public static int getGenMachineId()
  {
    return _genmachine;
  }

  public static int getCurrentCounter()
  {
    return _nextInc.get();
  }

  @Deprecated
  public static int getCurrentInc()
  {
    return _nextInc.get();
  }

  @Deprecated
  public static int _flip(int x)
  {
    int z = 0;
    z |= x << 24 & 0xFF000000;
    z |= x << 8 & 0xFF0000;
    z |= x >> 8 & 0xFF00;
    z |= x >> 24 & 0xFF;
    return z;
  }

  static
  {
    try
    {
      int machinePiece;
      try
      {
        StringBuilder sb = new StringBuilder();
        Enumeration e = NetworkInterface.getNetworkInterfaces();
        while (e.hasMoreElements()) {
          NetworkInterface ni = (NetworkInterface)e.nextElement();
          sb.append(ni.toString());
        }
        machinePiece = sb.toString().hashCode() << 16;
      }
      catch (Throwable e) {
        LOGGER.log(Level.WARNING, e.getMessage(), e);
        machinePiece = new Random().nextInt() << 16;
      }
      LOGGER.fine("machine piece post: " + Integer.toHexString(machinePiece));

      int processId = new Random().nextInt();
      try {
        processId = ManagementFactory.getRuntimeMXBean().getName().hashCode();
      }
      catch (Throwable t)
      {
      }
      ClassLoader loader = ObjectId.class.getClassLoader();
      int loaderId = loader != null ? System.identityHashCode(loader) : 0;

      StringBuilder sb = new StringBuilder();
      sb.append(Integer.toHexString(processId));
      sb.append(Integer.toHexString(loaderId));
      int processPiece = sb.toString().hashCode() & 0xFFFF;
      LOGGER.fine("process piece: " + Integer.toHexString(processPiece));

      _genmachine = machinePiece | processPiece;
      LOGGER.fine("machine : " + Integer.toHexString(_genmachine));
    }
    catch (Exception e) {
      throw new RuntimeException(e);
    }
  }
}