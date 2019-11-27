package roteiro;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexaoJDBC {

	private static String driver = "org.postgresql.Driver";
	private static String url = "jdbc:postgresql://address:porta/"; // Alterar
	 
	private static String nomeBD = "nomeDoSeuBanco"; // Alterar
	private static String usuarioBD = "seuUsuario"; // Alterar
	private static String senhaBD = "suaSenha"; // Alterar
	 

	  public static Connection criarConexao() {
	    
	    final String urlConexao = url + nomeBD;

	    Connection conexao = null;

	    try {
	      
	      Class.forName(driver);
	      conexao = DriverManager.getConnection(urlConexao, usuarioBD, senhaBD);
	      conexao.setAutoCommit(false);
	      
	      System.out.println("Conexao com o banco " + nomeBD + " aberta com sucesso!!!");

	    } catch (Exception e) {
	      
	      System.err.println(e.getClass().getName() + ": " + e.getMessage());
	      System.exit(0);
	      
	    }
	    
	    return conexao;
	    
	  }

	
}
