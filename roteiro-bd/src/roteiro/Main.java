package roteiro;

import java.sql.SQLException;

public class Main {
	public static void main(String[] args) {
	    
	    String sql = null;
	    PreparedStatement stmt = null;
	    
	    try {
	      
	          // Fabrica uma conexao com o banco de dados
	          Connection conn = ConexaoJDBC.criarConexao();
	      
	          Laboratorio lab = new Laboratorio("LMD", "Laboratorio de Mineracao de Dados");
	      
	          // Sql para insercao de um novo laboratorio
	          sql = "INSERT INTO laboratorio (nome, descricao) VALUES (?,?);";
	      
	          stmt = conn.prepareStatement(sql);
	      
	          // Substitui os parametros de interrogacao pelos respectivos valores
	          stmt.setString(1, lab.getNome());
	          stmt.setString(2, lab.getDescricao());
	          stmt.execute();
	      
	          // Executa a operacao
	          conn.commit();

	    } catch (SQLException e) {
	      
	          e.printStackTrace();
	      
	    }
	    
	  }

}
